import 'dart:typed_data';

import 'package:customertaxi/common/imports/imports.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

import '../../../../../core/services/file_download/file_download_service.dart';
import '../../../../../core/services/file_download/file_saved_result_presenter.dart';
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
      await presentFileSaveResult(
        context,
        result,
        onShare: () => _onSharePressed(bytes),
        dialogTitle: AppStrings.invoiceSavedDialogTitle,
      );
    } finally {
      if (mounted) setState(() => _downloading = false);
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
