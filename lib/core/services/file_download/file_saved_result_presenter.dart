import 'package:customertaxi/common/imports/imports.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';

import 'file_download_service.dart';

/// Presents the outcome of a [FileDownloadService.saveBytes] call to the user:
/// a saved-path dialog (with Open / Share) when we have a real path, a
/// "Saved to Downloads/Files/..." snackbar otherwise, and the failure-reason
/// snackbars (incl. an "Open settings" action for permanent denial).
///
/// Shared by the invoice screen and the in-trip recording sheet so both flows
/// tell the user *where* the file landed in exactly the same way.
Future<void> presentFileSaveResult(
  BuildContext context,
  FileDownloadResult result, {
  required Future<void> Function() onShare,
  required String dialogTitle,
}) async {
  switch (result) {
    case FileDownloadSuccess(:final location, :final path):
      if (path != null && path.isNotEmpty) {
        await _showSavedDialog(context, dialogTitle, path, onShare);
      } else {
        _showSnack(context, _successMessage(location));
      }
    case FileDownloadFailure(:final reason):
      _handleFailure(context, reason);
  }
}

String _successMessage(FileDownloadLocation location) {
  switch (location) {
    case FileDownloadLocation.publicDownloads:
      return AppStrings.invoiceSavedToDownloads;
    case FileDownloadLocation.appDocuments:
      return AppStrings.invoiceSavedToFiles;
    case FileDownloadLocation.appExternalDir:
      return AppStrings.invoiceSavedToAppFolder;
    case FileDownloadLocation.sharedTemporarily:
      return AppStrings.invoiceSavedSharedFallback;
  }
}

/// Shows where the file was saved with actions to open it externally or share it.
Future<void> _showSavedDialog(
  BuildContext context,
  String title,
  String path,
  Future<void> Function() onShare,
) async {
  await showDialog<void>(
    context: context,
    builder: (dialogContext) => AlertDialog(
      title: Text(title),
      content: SelectableText(path, style: AppTextStyles.s14w400),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(dialogContext).pop(),
          child: Text(AppStrings.invoiceClose),
        ),
        TextButton(
          onPressed: () {
            Navigator.of(dialogContext).pop();
            onShare();
          },
          child: Text(AppStrings.invoiceShare),
        ),
        FilledButton(
          onPressed: () async {
            Navigator.of(dialogContext).pop();
            await _openFile(context, path);
          },
          child: Text(AppStrings.invoiceOpen),
        ),
      ],
    ),
  );
}

Future<void> _openFile(BuildContext context, String path) async {
  final result = await OpenFilex.open(path);
  if (!context.mounted) return;
  if (result.type != ResultType.done) {
    printY('[FileSaveResult] open failed=${result.type} ${result.message}');
    _showSnack(context, AppStrings.invoiceOpenFailed);
  }
}

void _handleFailure(BuildContext context, FileDownloadFailureReason reason) {
  switch (reason) {
    case FileDownloadFailureReason.permissionPermanentlyDenied:
      _showSnack(
        context,
        AppStrings.invoicePermissionPermanentlyDenied,
        action: SnackBarAction(
          label: AppStrings.invoiceOpenSettings,
          onPressed: openAppSettings,
        ),
      );
    case FileDownloadFailureReason.permissionDenied:
      _showSnack(context, AppStrings.invoicePermissionDenied);
    case FileDownloadFailureReason.storageFull:
      _showSnack(context, AppStrings.invoiceStorageFull);
    case FileDownloadFailureReason.cancelled:
      // user dismissed the share sheet — stay silent
      break;
    case FileDownloadFailureReason.ioError:
    case FileDownloadFailureReason.unsupportedPlatform:
      _showSnack(context, AppStrings.invoiceDownloadFailed);
  }
}

void _showSnack(BuildContext context, String message, {SnackBarAction? action}) {
  ScaffoldMessenger.of(
    context,
  ).showSnackBar(SnackBar(content: Text(message), action: action));
}
