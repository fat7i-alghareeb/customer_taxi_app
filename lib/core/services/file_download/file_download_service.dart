import 'dart:typed_data';

/// Where the file actually landed. The UI uses this to decide which
/// success message to show (e.g. "Saved to Downloads" vs "Opened share sheet").
enum FileDownloadLocation {
  /// Android: public Downloads folder when a platform save path can provide it.
  /// iOS: Files app via the Documents container.
  publicDownloads,

  /// Android: app-private external dir (`Android/data/<pkg>/files/Download/`).
  /// Visible in file managers; removed on uninstall.
  appExternalDir,

  /// iOS: app Documents directory (visible in Files when sharing is enabled).
  appDocuments,

  /// We could not save locally — share sheet was opened so the user can
  /// route the bytes elsewhere (Drive, Files, etc.).
  sharedTemporarily,
}

/// Reasons a save attempt can fail. The UI maps each to a localized message
/// and, for [permissionPermanentlyDenied], an "Open settings" action.
enum FileDownloadFailureReason {
  permissionDenied,
  permissionPermanentlyDenied,
  storageFull,
  ioError,
  cancelled,
  unsupportedPlatform,
}

sealed class FileDownloadResult {
  const FileDownloadResult();
}

final class FileDownloadSuccess extends FileDownloadResult {
  const FileDownloadSuccess({required this.location, this.path, this.uri});

  /// Filesystem path when available. Null for [FileDownloadLocation.sharedTemporarily].
  final String? path;

  /// Content URI when a platform save API provides one. Null for file paths.
  final Uri? uri;

  final FileDownloadLocation location;
}

final class FileDownloadFailure extends FileDownloadResult {
  const FileDownloadFailure({required this.reason, this.cause});

  final FileDownloadFailureReason reason;
  final Object? cause;
}

/// Persists arbitrary bytes to user-visible storage with platform-appropriate
/// fallbacks. Used today for invoice PDFs; reusable for receipts, exports, etc.
abstract class FileDownloadService {
  /// Saves [bytes] under [fileName] with [mimeType] (used by the native saver
  /// and share sheet metadata). The returned result tells the caller *where* the
  /// file ended up so it can show the right confirmation copy.
  Future<FileDownloadResult> saveBytes({
    required Uint8List bytes,
    required String fileName,
    required String mimeType,
  });
}
