import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:injectable/injectable.dart';
import 'package:media_store_plus/media_store_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';

import '../../../utils/helpers/colored_print.dart';
import 'file_download_service.dart';

/// Cascading save strategy:
///
/// **Android**
///   1. SDK ≥ 29: `MediaStore.Downloads` (no permission, lands in Downloads app).
///   2. SDK ≤ 28: legacy `WRITE_EXTERNAL_STORAGE` + direct write to
///      `/storage/emulated/0/Download`.
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

  static const _appFolder = 'Fat7i';

  final MediaStore _mediaStore = MediaStore();

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

    // Strategy 1 + 2 (MediaStore handles both 29+ and the legacy direct-write
    // path internally — much less code to maintain than two branches).
    try {
      await MediaStore.ensureInitialized();
      MediaStore.appFolder = _appFolder;

      final temp = await _writeTemp(bytes, fileName);
      final info = await _mediaStore.saveFile(
        tempFilePath: temp.path,
        dirType: DirType.download,
        dirName: DirName.download,
      );

      // Always sweep the temp file regardless of MediaStore's outcome.
      unawaited(temp.delete().catchError((_) => temp));

      if (info != null) {
        printY(
          '[FileDownload] mediaStore ok name=${info.name} status=${info.saveStatus.name}',
        );
        return FileDownloadSuccess(
          location: FileDownloadLocation.publicDownloads,
          path: info.uri.toString(),
          uri: info.uri,
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
      printY('[FileDownload] mediaStore FileSystemException: $e');
    } catch (e) {
      printY('[FileDownload] mediaStore failed: $e');
    }

    return _appExternalDirFallback(bytes, fileName, mimeType);
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
          files: [
            XFile.fromData(bytes, name: fileName, mimeType: mimeType),
          ],
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

  Future<File> _writeTemp(Uint8List bytes, String fileName) async {
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    return _writeBytesAtomically(file.path, bytes);
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

  /// Strip the characters that break either filesystem or MediaStore inserts.
  String _sanitize(String name) =>
      name.replaceAll(RegExp(r'[\\/:*?"<>|]'), '_').trim();
}
