import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/services/support_contact/support_contact_service.dart';
import '../../../constants/forms/refund_issue_forms.dart';
import '../../../domain/entities/refund_issue_request_type.dart';
import '../../states/refund_issue_bloc.dart';
import '../screens/refund_issue_screen.dart';
import 'refund_issue_info_card.dart';
import 'refund_issue_note_field.dart';
import 'refund_issue_reason_option_tile.dart';
import 'refund_issue_success_panel.dart';
import 'refund_issue_summary_card.dart';

class RefundIssueBody extends StatefulWidget {
  const RefundIssueBody({super.key, required this.args, required this.form});

  final RefundIssueScreenArgs args;
  final FormGroup form;

  @override
  State<RefundIssueBody> createState() => RefundIssueBodyState();
}

class RefundIssueBodyState extends State<RefundIssueBody> {
  @override
  void initState() {
    super.initState();
    if (widget.args.knownFailedRefund) {
      context.read<RefundIssueBloc>().add(
        const RefundIssueEvent.reasonSelected(
          RefundIssueRequestType.knownFailedRefundReview,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RefundIssueBloc, RefundIssueState>(
      listenWhen: (previous, current) =>
          previous.submitStatus != current.submitStatus,
      listener: (context, state) {
        state.submitStatus.maybeWhen(
          success: (_) =>
              showSuccessOverlay(context, AppStrings.refundIssueSubmitSuccess),
          failure: (message) => showErrorOverlay(context, message),
          orElse: () {},
        );
      },
      child: BlocBuilder<RefundIssueBloc, RefundIssueState>(
        builder: (context, state) {
          final issue = state.submitStatus.getDataWhenSuccess;
          if (issue != null) {
            return RefundIssueSuccessPanel(
              referenceCode: widget.args.referenceCode,
              onOpenWhatsApp: () => _openWhatsApp(context),
            );
          }

          return ReactiveForm(
            formGroup: widget.form,
            child: SingleChildScrollView(
              padding: REdgeInsets.fromLTRB(
                AppSpacing.xl,
                AppSpacing.lg,
                AppSpacing.xl,
                AppSpacing.xxl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RefundIssueSummaryCard(args: widget.args)
                      .animate()
                      .fadeIn(duration: AppDurations.normal)
                      .slideY(begin: 0.08, end: 0),
                  AppSpacing.lg.verticalSpace,
                  RefundIssueInfoCard(
                        knownFailed: widget.args.knownFailedRefund,
                      )
                      .animate(delay: AppDurations.fast)
                      .fadeIn(duration: AppDurations.normal)
                      .slideY(begin: 0.08, end: 0),
                  AppSpacing.lg.verticalSpace,
                  if (!widget.args.knownFailedRefund)
                    ..._options(state.selectedType).map(
                      (option) => Padding(
                        padding: REdgeInsets.only(bottom: AppSpacing.sm),
                        child: RefundIssueReasonOptionTile(
                          option: option,
                          selected: state.selectedType == option.type,
                          onTap: () => context.read<RefundIssueBloc>().add(
                            RefundIssueEvent.reasonSelected(option.type),
                          ),
                        ),
                      ),
                    ),
                  RefundIssueNoteField(form: widget.form)
                      .animate(delay: AppDurations.normal)
                      .fadeIn(duration: AppDurations.normal)
                      .slideY(begin: 0.08, end: 0),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  List<RefundIssueReasonOption> _options(RefundIssueRequestType selectedType) =>
      [
        RefundIssueReasonOption(
          type: RefundIssueRequestType.didNotReceiveRefund,
          icon: FontAwesomeIcons.circleQuestion,
          label: AppStrings.refundIssueReasonDidNotReceive,
        ),
        RefundIssueReasonOption(
          type: RefundIssueRequestType.receivedLessThanExpected,
          icon: FontAwesomeIcons.scaleBalanced,
          label: AppStrings.refundIssueReasonLessThanExpected,
        ),
        RefundIssueReasonOption(
          type: RefundIssueRequestType.refundTakingTooLong,
          icon: FontAwesomeIcons.clock,
          label: AppStrings.refundIssueReasonTakingTooLong,
        ),
        RefundIssueReasonOption(
          type: RefundIssueRequestType.questionAboutRefund,
          icon: FontAwesomeIcons.comments,
          label: AppStrings.refundIssueReasonQuestion,
        ),
        RefundIssueReasonOption(
          type: RefundIssueRequestType.other,
          icon: FontAwesomeIcons.ellipsis,
          label: AppStrings.refundIssueReasonOther,
        ),
      ];

  Future<void> _openWhatsApp(BuildContext context) async {
    final number = getIt<SupportContactService>().whatsApp;
    final message = AppStrings.refundIssueWhatsAppMessage
        .replaceAll('{reference}', widget.args.referenceCode)
        .replaceAll(
          '{amount}',
          _formatAmount(widget.args.refundAmount, widget.args.currencyCode),
        );
    final uri = Uri.parse(
      'https://wa.me/$number?text=${Uri.encodeComponent(message)}',
    );
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  String _formatAmount(double value, String currencyCode) =>
      '${value.toStringAsFixed(2)} $currencyCode';
}

class RefundIssueBottomAction extends StatelessWidget {
  const RefundIssueBottomAction({
    super.key,
    required this.args,
    required this.form,
  });

  final RefundIssueScreenArgs args;
  final FormGroup form;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RefundIssueBloc, RefundIssueState>(
      builder: (context, state) {
        final isDone = state.submitStatus.isSuccess;
        if (isDone) {
          return const SizedBox.shrink();
        }

        return SafeArea(
          top: false,
          child: Container(
            padding: REdgeInsets.fromLTRB(
              AppSpacing.xl,
              AppSpacing.md,
              AppSpacing.xl,
              AppSpacing.lg,
            ),
            decoration: BoxDecoration(
              color: context.surface,
              border: Border(
                top: BorderSide(
                  color: context.onSurface.withValues(alpha: 0.08),
                ),
              ),
            ),
            child: AppButton.warningGradient(
              isLoading: state.submitStatus.isLoading,
              isActive: !state.submitStatus.isLoading,
              onTap: () {
                final noteText = form.valueOf<String>(
                  RefundIssueForms.noteField,
                );
                final type = args.knownFailedRefund
                    ? RefundIssueRequestType.knownFailedRefundReview
                    : state.selectedType;
                context.read<RefundIssueBloc>().add(
                  RefundIssueEvent.submitted(
                    tripId: args.tripId,
                    type: type,
                    customerReason: _labelFor(type),
                    note: noteText,
                  ),
                );
              },
              child: AppButtonChild.labelIcon(
                label: AppStrings.refundIssueSubmitCta,
                icon: IconSource.faIcon(FontAwesomeIcons.paperPlane),
              ),
            ),
          ),
        );
      },
    );
  }

  String _labelFor(RefundIssueRequestType type) => switch (type) {
    RefundIssueRequestType.didNotReceiveRefund =>
      AppStrings.refundIssueReasonDidNotReceive,
    RefundIssueRequestType.receivedLessThanExpected =>
      AppStrings.refundIssueReasonLessThanExpected,
    RefundIssueRequestType.refundTakingTooLong =>
      AppStrings.refundIssueReasonTakingTooLong,
    RefundIssueRequestType.questionAboutRefund =>
      AppStrings.refundIssueReasonQuestion,
    RefundIssueRequestType.knownFailedRefundReview =>
      AppStrings.refundIssueKnownFailedReason,
    RefundIssueRequestType.other => AppStrings.refundIssueReasonOther,
  };
}
