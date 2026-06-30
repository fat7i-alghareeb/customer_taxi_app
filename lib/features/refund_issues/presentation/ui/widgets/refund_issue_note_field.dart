import 'package:customertaxi/common/imports/imports.dart';

import '../../../constants/forms/refund_issue_forms.dart';

class RefundIssueNoteField extends StatelessWidget {
  const RefundIssueNoteField({super.key, required this.form});

  final FormGroup form;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: REdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: context.surface,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: context.onSurface.withValues(alpha: 0.08)),
      ),
      child: AppReactiveTextField.text(
        formGroup: form,
        formControlName: RefundIssueForms.noteField,
        title: AppStrings.refundIssueNoteTitle,
        hintText: AppStrings.refundIssueNoteHint,
        minLines: 4,
        maxLines: 6,
      ),
    );
  }
}
