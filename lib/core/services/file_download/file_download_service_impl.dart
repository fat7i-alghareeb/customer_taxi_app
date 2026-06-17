import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:file_saver/file_saver.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/helpers/colored_print.dart';
import 'file_download_service.dart';

/// Cascading save strategy:
///
/// **Android**
///   1. Public Downloads via native MediaStore (`/storage/emulated/0/Download/`).
///   2. FileSaver app-external save.
///   3. App-private external dir (`Android/data/<pkg>/files/Download/`).
///   4. Share sheet ("Save to Drive/Files/etc.").
///
/// **iOS**
///   1. App Documents dir (visible in Files when `UIFileSharingEnabled` +
///      `LSSupportsOpeningDocumentsInPlace` are set in Info.plist).
///   2. Share sheet ("Save to Files").
@LazySingleton(as: FileDownloadService)
class FileDownloadServiceImpl implements FileDownloadService {
  FileDownloadServiceImpl();

  /// Native channel that saves into the public Downloads folder via MediaStore.
  /// Mirrors the handler registered in `MainActivity` (`dev.fat7i.customertaxi`).
  static const MethodChannel _downloadsChannel =
      MethodChannel('dev.fat7i.customertaxi/downloads');

  @override
  Future<FileDownloadResult> saveBytes({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
  }) async {
    final safeName = _sanitize(fileName);

    if (Platform.isAndroid) {
      return _androidSave(bytes, safeName, mimeType);
    }
    if (Platform.isIOS) {
      return _iosSave(bytes, safeName, mimeType);
    }
    return const FileDownloadFailure(
      reason: FileDownloadFailureReason.unsupportedPlatform,
    );
  }

  // ─────────────────────────────── Android ───────────────────────────────

  Future<FileDownloadResult> _androidSave(
    Uint8List bytes,
    String fileName,
    String mimeType,
  ) async {
    final sdk = (await DeviceInfoPlugin().androidInfo).version.sdkInt;
    printM('[FileDownload] android sdk=$sdk');

    // Legacy WRITE_EXTERNAL_STORAGE only matters on SDK ≤ 28; on 29+ scoped
    // storage makes the permission a no-op (and on 33+ the permission was
    // removed). Request only where it can actually grant something.
    if (sdk <= 28) {
      final perm = await Permission.storage.request();
      if (perm.isPermanentlyDenied) {
        return const FileDownloadFailure(
          reason: FileDownloadFailureReason.permissionPermanentlyDenied,
        );
      }
      if (perm.isDenied || perm.isRestricted) {
        return _appExternalDirFallback(bytes, fileName, mimeType);
      }
    }

    // Strategy 1: public Downloads folder via native MediaStore. Permission-less
    // on SDK 29+; on ≤ 28 it relies on the storage permission granted above.
    final publicResult = await _publicDownloadsSave(bytes, fileName, mimeType);
    if (publicResult != null) {
      return publicResult;
    }

    // Strategy 2: file_saver uses app-scoped storage on Android, which avoids
    // public-storage plugin metadata conflicts in release builds.
    try {
      final path = await FileSaver.instance.saveFile(
        name: _nameWithoutExtension(fileName),
        bytes: bytes,
        fileExtension: _extensionWithoutDot(fileName),
        includeExtension: _extensionWithoutDot(fileName).isNotEmpty,
        mimeType: MimeType.custom,
        customMimeType: mimeType,
      );

      if (path.isNotEmpty) {
        printY('[FileDownload] fileSaver ok path=$path');
        return FileDownloadSuccess(
          location: FileDownloadLocation.appExternalDir,
          path: path,
        );
      }
    } on FileSystemException catch (e) {
      // ENOSPC = 28 on POSIX. Surface a dedicated reason so the UI can hint at it.
      if (e.osError?.errorCode == 28) {
        return FileDownloadFailure(
          reason: FileDownloadFailureReason.storageFull,
          cause: e,
        );
      }
      printY('[FileDownload] fileSaver FileSystemException: $e');
    } catch (e) {
      printY('[FileDownload] fileSaver failed: $e');
    }

    return _appExternalDirFallback(bytes, fileName, mimeType);
  }

  /// Strategy 1 — public Downloads via native MediaStore. Returns a success with
  /// the absolute file path, or `null` to let the caller fall through to the
  /// app-scoped strategies (e.g. plugin missing, denied, or any platform error).
  Future<FileDownloadResult?> _publicDownloadsSave(
    Uint8List bytes,
    String fileName,
    String mimeType,
  ) async {
    try {
      final path = await _downloadsChannel.invokeMethod<String>(
        'saveToDownloads',
        <String, dynamic>{
          'bytes': bytes,
          'fileName': fileName,
          'mimeType': mimeType,
        },
      );
      if (path != null && path.isNotEmpty) {
        printY('[FileDownload] mediaStore ok path=$path');
        return FileDownloadSuccess(
          location: FileDownloadLocation.publicDownloads,
          path: path,
        );
      }
    } on MissingPluginException catch (e) {
      printY('[FileDownload] mediaStore channel missing: $e');
    } on PlatformException catch (e) {
      printY('[FileDownload] mediaStore failed: ${e.code} ${e.message}');
    } catch (e) {
      printY('[FileDownload] mediaStore unexpected: $e');
    }
    return null;
  }

  /// Strategy 3 — Android app-private external dir. Always succeeds on devices
  /// with external storage; appears in file managers under
  /// `Android/data/<pkg>/files/Download/`.
  Future<FileDownloadResult> _appExternalDirFallback(
    Uint8List bytes,
    String fileName,
    String mimeType,
  ) async {
    try {
      final root = await getExternalStorageDirectory();
      if (root != null) {
        final dir = Directory('${root.path}/Download');
        if (!await dir.exists()) {
          await dir.create(recursive: true);
        }
        final file = await _writeBytesAtomically(
          _uniquePath(dir, fileName),
          bytes,
        );
        return FileDownloadSuccess(
          location: FileDownloadLocation.appExternalDir,
          path: file.path,
        );
      }
    } on FileSystemException catch (e) {
      if (e.osError?.errorCode == 28) {
        return FileDownloadFailure(
          reason: FileDownloadFailureReason.storageFull,
          cause: e,
        );
      }
      printY('[FileDownload] appExternalDir FileSystemException: $e');
    } catch (e) {
      printY('[FileDownload] appExternalDir failed: $e');
    }

    return _shareFallback(bytes, fileName, mimeType);
  }

  // ───────────────────────────────── iOS ─────────────────────────────────

  Future<FileDownloadResult> _iosSave(
    Uint8List bytes,
    String fileName,
    String mimeType,
  ) async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      final file = await _writeBytesAtomically(
        _uniquePath(dir, fileName),
        bytes,
      );
      return FileDownloadSuccess(
        location: FileDownloadLocation.appDocuments,
        path: file.path,
      );
    } on FileSystemException catch (e) {
      if (e.osError?.errorCode == 28) {
        return FileDownloadFailure(
          reason: FileDownloadFailureReason.storageFull,
          cause: e,
        );
      }
      printY('[FileDownload] iOS documents save FileSystemException: $e');
    } catch (e) {
      printY('[FileDownload] iOS documents save failed: $e');
    }

    return _shareFallback(bytes, fileName, mimeType);
  }

  // ──────────────────────────── Shared helpers ───────────────────────────

  /// Strategy 4 — last-ditch: hand the bytes to the OS share sheet.
  Future<FileDownloadResult> _shareFallback(
    Uint8List bytes,
    String fileName,
    String mimeType,
  ) async {
    try {
      final result = await SharePlus.instance.share(
        ShareParams(
          files: [XFile.fromData(bytes, name: fileName, mimeType: mimeType)],
        ),
      );
      if (result.status == ShareResultStatus.dismissed) {
        return const FileDownloadFailure(
          reason: FileDownloadFailureReason.cancelled,
        );
      }
      return const FileDownloadSuccess(
        location: FileDownloadLocation.sharedTemporarily,
      );
    } catch (e) {
      return FileDownloadFailure(
        reason: FileDownloadFailureReason.ioError,
        cause: e,
      );
    }
  }

  /// Write to `<path>.tmp` then rename — guarantees no half-written file is
  /// ever visible under the final name, even if the OS kills us mid-write.
  Future<File> _writeBytesAtomically(String path, Uint8List bytes) async {
    final tmp = File('$path.tmp');
    await tmp.writeAsBytes(bytes, flush: true);
    return tmp.rename(path);
  }

  String _uniquePath(Directory dir, String fileName) {
    final initial = '${dir.path}/$fileName';
    if (!File(initial).existsSync()) return initial;

    final dot = fileName.lastIndexOf('.');
    final base = dot < 0 ? fileName : fileName.substring(0, dot);
    final ext = dot < 0 ? '' : fileName.substring(dot);

    var i = 1;
    while (true) {
      final candidate = '${dir.path}/$base ($i)$ext';
      if (!File(candidate).existsSync()) return candidate;
      i++;
    }
  }

  String _nameWithoutExtension(String fileName) {
    final dot = fileName.lastIndexOf('.');
    if (dot <= 0) return fileName;
    return fileName.substring(0, dot);
  }

  String _extensionWithoutDot(String fileName) {
    final dot = fileName.lastIndexOf('.');
    if (dot < 0 || dot == fileName.length - 1) return '';
    return fileName.substring(dot + 1);
  }

  /// Strip the characters that break filesystem writes.
  String _sanitize(String name) =>
      name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_').trim();
}
