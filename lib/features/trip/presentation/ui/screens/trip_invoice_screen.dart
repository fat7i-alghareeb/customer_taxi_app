import 'dart:typed_data';

import 'package:customertaxi/common/imports/imports.dart';
import 'package:open_filex/open_filex.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../core/services/file_download/file_download_service.dart';
import '../../states/trip_bloc.dart';

/// Customer-facing invoice PDF screen — mirrors the Uber "الفاتورة" reference.
/// The PDF is rendered server-side in the app's currently-selected language;
/// unknown / unsupported codes safely fall back to Dutch on the backend.
class TripInvoiceScreen extends StatelessWidget {
  const TripInvoiceScreen({super.key});

  static const String pagePath = '/trip_invoice';
  static const String pageName = 'TripInvoiceScreen';

  @override
  Widget build(BuildContext context) {
    final state = GoRouterState.of(context);
    final tripId =
        (state.extra as String?) ?? state.uri.queryParameters['id'] ?? '';
    final languageCode = context.locale.languageCode;

    return BlocProvider<TripBloc>(
      create: (_) => getIt<TripBloc>()
        ..add(
          TripEvent.loadInvoicePdf(tripId: tripId, languageCode: languageCode),
        )
        // Also load invoice details so we can name the file by its invoice number.
        ..add(TripEvent.loadInvoice(tripId)),
      child: AppScaffold.appBar(
        appBarConfig: AppScaffoldAppBarConfig(title: AppStrings.invoiceTitle),
        child: _TripInvoiceBody(tripId: tripId, languageCode: languageCode),
      ),
    );
  }
}

class _TripInvoiceBody extends StatefulWidget {
  const _TripInvoiceBody({required this.tripId, required this.languageCode});

  final String tripId;
  final String languageCode;

  @override
  State<_TripInvoiceBody> createState() => _TripInvoiceBodyState();
}

class _TripInvoiceBodyState extends State<_TripInvoiceBody> {
  bool _downloading = false;

  /// Names the file by its invoice number when loaded, e.g. `OT-2026-000123.pdf`.
  /// Falls back to the trip-based name if invoice details aren't available yet.
  String _fileName() {
    final number = context
        .read<TripBloc>()
        .state
        .invoiceStatus
        .getDataWhenSuccess
        ?.invoiceNumber;
    if (number != null && number.trim().isNotEmpty) {
      return '${number.trim()}.pdf';
    }
    return 'fat7i-invoice-${widget.tripId}.pdf';
  }

  Future<void> _onSharePressed(Uint8List bytes) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              bytes,
              name: _fileName(),
              mimeType: 'application/pdf',
            ),
          ],
          subject: AppStrings.invoiceTitle,
        ),
      );
    } catch (e) {
      printY('[TripInvoice] share failed=$e');
      if (mounted) {
        _showSnack(AppStrings.invoiceDownloadFailed);
      }
    }
  }

  Future<void> _onDownloadPressed(Uint8List bytes) async {
    if (_downloading) return;
    setState(() => _downloading = true);
    try {
      final result = await getIt<FileDownloadService>().saveBytes(
        bytes: bytes,
        fileName: _fileName(),
        mimeType: 'application/pdf',
      );
      if (!mounted) return;
      switch (result) {
        case FileDownloadSuccess(:final location, :final path):
          if (path != null && path.isNotEmpty) {
            await _showSavedDialog(path, bytes);
          } else {
            _showSnack(_successMessage(location));
          }
        case FileDownloadFailure(:final reason):
          _handleFailure(reason);
      }
    } finally {
      if (mounted) setState(() => _downloading = false);
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

  /// Shows where the PDF was saved with actions to open it externally or share it.
  Future<void> _showSavedDialog(String path, Uint8List bytes) async {
    if (!mounted) return;
    await showDialog<void>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppStrings.invoiceSavedDialogTitle),
        content: SelectableText(path, style: AppTextStyles.s14w400),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(AppStrings.invoiceClose),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(dialogContext).pop();
              _onSharePressed(bytes);
            },
            child: Text(AppStrings.invoiceShare),
          ),
          FilledButton(
            onPressed: () async {
              Navigator.of(dialogContext).pop();
              await _openFile(path);
            },
            child: Text(AppStrings.invoiceOpen),
          ),
        ],
      ),
    );
  }

  Future<void> _openFile(String path) async {
    final result = await OpenFilex.open(path);
    if (!mounted) return;
    if (result.type != ResultType.done) {
      printY('[TripInvoice] open failed=${result.type} ${result.message}');
      _showSnack(AppStrings.invoiceOpenFailed);
    }
  }

  void _handleFailure(FileDownloadFailureReason reason) {
    switch (reason) {
      case FileDownloadFailureReason.permissionPermanentlyDenied:
        _showSnack(
          AppStrings.invoicePermissionPermanentlyDenied,
          action: SnackBarAction(
            label: AppStrings.invoiceOpenSettings,
            onPressed: openAppSettings,
          ),
        );
      case FileDownloadFailureReason.permissionDenied:
        _showSnack(AppStrings.invoicePermissionDenied);
      case FileDownloadFailureReason.storageFull:
        _showSnack(AppStrings.invoiceStorageFull);
      case FileDownloadFailureReason.cancelled:
        // user dismissed the share sheet — stay silent
        break;
      case FileDownloadFailureReason.ioError:
      case FileDownloadFailureReason.unsupportedPlatform:
        _showSnack(AppStrings.invoiceDownloadFailed);
    }
  }

  void _showSnack(String message, {SnackBarAction? action}) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message), action: action));
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TripBloc, TripState>(
      buildWhen: (a, b) => a.invoicePdfStatus != b.invoicePdfStatus,
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: StatusBuilder<Uint8List>(
                state: state.invoicePdfStatus,
                onError: () => context.read<TripBloc>().add(
                  TripEvent.loadInvoicePdf(
                    tripId: widget.tripId,
                    languageCode: widget.languageCode,
                  ),
                ),
                errorMessage: AppStrings.invoiceLoadFailed,
                success: (bytes) => bytes.isEmpty
                    ? Center(
                        child: Padding(
                          padding: REdgeInsets.all(AppSpacing.xl),
                          child: Text(
                            AppStrings.invoiceNotIssuedYet,
                            textAlign: TextAlign.center,
                            style: AppTextStyles.s14w400,
                          ),
                        ),
                      )
                    : SfPdfViewer.memory(bytes),
              ),
            ),
            _BottomBar(
              onShare: _onSharePressed,
              onDownload: _onDownloadPressed,
              isDownloading: _downloading,
            ),
          ],
        );
      },
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.onShare,
    required this.onDownload,
    required this.isDownloading,
  });

  final ValueChanged<Uint8List> onShare;
  final ValueChanged<Uint8List> onDownload;
  final bool isDownloading;

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    return BlocBuilder<TripBloc, TripState>(
      buildWhen: (a, b) => a.invoicePdfStatus != b.invoicePdfStatus,
      builder: (context, state) {
        final bytes = state.invoicePdfStatus.getDataWhenSuccess;
        final isReady = bytes != null && bytes.isNotEmpty;
        final isLoading = state.invoicePdfStatus.isLoading;
        return Container(
          width: double.infinity,
          padding: REdgeInsets.fromLTRB(
            AppSpacing.xl,
            AppSpacing.md,
            AppSpacing.xl,
            AppSpacing.md + bottomPad,
          ),
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            border: Border(
              top: BorderSide(
                color: context.colorScheme.onSurface.withValues(alpha: 0.06),
                width: 1.r,
              ),
            ),
          ),
          child: Row(
            children: [
              Expanded(
                child: AppButton.outline(
                  onTap: isReady ? () => onShare(bytes) : null,
                  isLoading: isLoading,
                  child: AppButtonChild.label(AppStrings.invoiceShare),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: AppButton.primary(
                  onTap: isReady && !isDownloading
                      ? () => onDownload(bytes)
                      : null,
                  isLoading: isLoading || isDownloading,
                  child: AppButtonChild.label(AppStrings.invoiceDownload),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
