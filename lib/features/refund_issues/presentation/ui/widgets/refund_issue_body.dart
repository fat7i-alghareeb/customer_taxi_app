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
import 'refund_issue_under_review_panel.dart';

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
              refundStatusSnapshot: issue.refundStatusSnapshot,
              onOpenWhatsApp: () => _openWhatsApp(context),
            );
          }

          // Checked after the fresh-submit case above, so submitting in this
          // session still lands on the success panel rather than jumping
          // straight to the (stale) "under review" state.
          final existing = widget.args.existingIssue;
          if (existing != null && existing.isOpen) {
            return RefundIssueUnderReviewPanel(
              submittedAtUtc: existing.createdAtUtc,
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
                  // A closed previous request freed the slot. Say so, otherwise
                  // being handed a blank form again reads as if the first
                  // request vanished.
                  if (existing?.reviewedAtUtc case final reviewedAt?) ...[
                    RefundIssueInfoCard(
                          message: AppStrings.refundIssuePreviousResolved
                              .replaceAll(
                                '{date}',
                                reviewedAt.toLocal().toYmd(),
                              ),
                        )
                        .animate()
                        .fadeIn(duration: AppDurations.normal)
                        .slideY(begin: 0.08, end: 0),
                    AppSpacing.lg.verticalSpace,
                  ],
                  RefundIssueSummaryCard(args: widget.args)
                      .animate()
                      .fadeIn(duration: AppDurations.normal)
                      .slideY(begin: 0.08, end: 0),
                  AppSpacing.lg.verticalSpace,
                  RefundIssueInfoCard.review(
                        knownFailed: widget.args.knownFailedRefund,
                      )
                      .animate(delay: AppDurations.fast)
                      .fadeIn(duration: AppDurations.normal)
                      .slideY(begin: 0.08, end: 0),
                  AppSpacing.lg.verticalSpace,
                  if (!widget.args.knownFailedRefund) ...[
                    _ReasonGroupCard(selectedType: state.selectedType)
                        .animate(delay: AppDurations.fast)
                        .fadeIn(duration: AppDurations.normal)
                        .slideY(begin: 0.08, end: 0),
                    AppSpacing.lg.verticalSpace,
                  ],
                  RefundIssueNoteField(form: widget.form)
                      .animate(delay: AppDurations.normal)
                      .fadeIn(duration: AppDurations.normal)
                      .slideY(begin: 0.08, end: 0),
                  AppSpacing.lg.verticalSpace,
                  RefundIssueInfoCard(
                        title: AppStrings.refundIssueWhatHappensTitle,
                        message: AppStrings.refundIssueWhatHappensBody,
                      )
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

/// Grouped card listing the refund reasons as a single radio list with a
/// section header and hairline dividers between rows.
class _ReasonGroupCard extends StatelessWidget {
  const _ReasonGroupCard({required this.selectedType});

  final RefundIssueRequestType selectedType;

  List<RefundIssueReasonOption> get _options => [
    RefundIssueReasonOption(
      type: RefundIssueRequestType.didNotReceiveRefund,
      label: AppStrings.refundIssueReasonDidNotReceive,
    ),
    RefundIssueReasonOption(
      type: RefundIssueRequestType.receivedLessThanExpected,
      label: AppStrings.refundIssueReasonLessThanExpected,
    ),
    RefundIssueReasonOption(
      type: RefundIssueRequestType.refundTakingTooLong,
      label: AppStrings.refundIssueReasonTakingTooLong,
    ),
    RefundIssueReasonOption(
      type: RefundIssueRequestType.questionAboutRefund,
      label: AppStrings.refundIssueReasonQuestion,
    ),
    RefundIssueReasonOption(
      type: RefundIssueRequestType.other,
      label: AppStrings.refundIssueReasonOther,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final options = _options;
    return Container(
      padding: REdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: REdgeInsets.symmetric(
              horizontal: AppSpacing.xs,
              vertical: AppSpacing.sm,
            ),
            child: Text(
              AppStrings.refundIssueReasonSectionTitle,
              style: AppTextStyles.s14w600.copyWith(color: context.onSurface),
            ),
          ),
          for (var i = 0; i < options.length; i++) ...[
            if (i > 0)
              Divider(
                height: 1.h,
                thickness: 1,
                color: context.onSurface.withValues(alpha: 0.06),
              ),
            RefundIssueReasonOptionTile(
              option: options[i],
              selected: selectedType == options[i].type,
              onTap: () => context.read<RefundIssueBloc>().add(
                RefundIssueEvent.reasonSelected(options[i].type),
              ),
            ),
          ],
        ],
      ),
    );
  }
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
        // Nothing to submit once this session succeeded, or while an earlier
        // request is still open — the server would reject it either way.
        final isDone = state.submitStatus.isSuccess;
        final isAwaitingReview = args.existingIssue?.isOpen ?? false;
        if (isDone || isAwaitingReview) {
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
            // Orange under the screen's tripAccentTheme wrapper, so this button
            // is visually continuous with the CTA the rider tapped to get here.
            child: AppButton.primaryGradient(
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

  String _labelFor(RefundIssueRequestType type) => type.title();
}
