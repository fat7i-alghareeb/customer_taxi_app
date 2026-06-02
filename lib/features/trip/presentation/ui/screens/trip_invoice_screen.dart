import 'dart:typed_data';

import 'package:customertaxi/common/imports/imports.dart';
import 'package:share_plus/share_plus.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

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
          TripEvent.loadInvoicePdf(
            tripId: tripId,
            languageCode: languageCode,
          ),
        ),
      child: AppScaffold.appBar(
        appBarConfig: AppScaffoldAppBarConfig(title: AppStrings.invoiceTitle),
        child: _TripInvoiceBody(
          tripId: tripId,
          languageCode: languageCode,
        ),
      ),
    );
  }
}

class _TripInvoiceBody extends StatelessWidget {
  const _TripInvoiceBody({required this.tripId, required this.languageCode});

  final String tripId;
  final String languageCode;

  Future<void> _onSharePressed(BuildContext context, Uint8List bytes) async {
    try {
      await SharePlus.instance.share(
        ShareParams(
          files: [
            XFile.fromData(
              bytes,
              name: 'invoice-$tripId-$languageCode.pdf',
              mimeType: 'application/pdf',
            ),
          ],
          subject: AppStrings.invoiceTitle,
        ),
      );
    } catch (e) {
      printY('[TripInvoice] share failed=$e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(AppStrings.invoiceLoadFailed)),
        );
      }
    }
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
                    tripId: tripId,
                    languageCode: languageCode,
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
              tripId: tripId,
              languageCode: languageCode,
              onShare: (bytes) => _onSharePressed(context, bytes),
            ),
          ],
        );
      },
    );
  }
}

class _BottomBar extends StatelessWidget {
  const _BottomBar({
    required this.tripId,
    required this.languageCode,
    required this.onShare,
  });

  final String tripId;
  final String languageCode;
  final ValueChanged<Uint8List> onShare;

  @override
  Widget build(BuildContext context) {
    final bottomPad = MediaQuery.paddingOf(context).bottom;
    return BlocBuilder<TripBloc, TripState>(
      buildWhen: (a, b) => a.invoicePdfStatus != b.invoicePdfStatus,
      builder: (context, state) {
        final bytes = state.invoicePdfStatus.getDataWhenSuccess;
        final canShare = bytes != null && bytes.isNotEmpty;
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
          child: AppButton.primary(
            onTap: canShare ? () => onShare(bytes) : null,
            isLoading: state.invoicePdfStatus.isLoading,
            child: AppButtonChild.label(AppStrings.invoiceDownload),
          ),
        );
      },
    );
  }
}
