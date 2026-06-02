import 'package:customertaxi/common/imports/imports.dart';

class PassengerNoteResult {
  const PassengerNoteResult(this.note);

  final String? note;
}

class PassengerNoteSheet extends StatefulWidget {
  const PassengerNoteSheet({super.key, this.initialNote});

  final String? initialNote;

  static Future<PassengerNoteResult?> show(
    BuildContext context, {
    String? initialNote,
  }) {
    return AppBottomSheet.show<PassengerNoteResult>(
      context,
      sheet: AppBottomSheet.basic(
        title: AppStrings.passengerNoteSheetTitle,
        child: PassengerNoteSheet(initialNote: initialNote),
      ),
    );
  }

  @override
  State<PassengerNoteSheet> createState() => _PassengerNoteSheetState();
}

class _PassengerNoteSheetState extends State<PassengerNoteSheet> {
  late final FormGroup _form;

  @override
  void initState() {
    super.initState();
    _form = FormGroup({
      'passengerNote': FormControl<String>(
        value: widget.initialNote ?? '',
        validators: [Validators.maxLength(500)],
      ),
    });
  }

  @override
  void dispose() {
    _form.dispose();
    super.dispose();
  }

  void _save() {
    final value = (_form.control('passengerNote').value as String?)?.trim();
    Navigator.pop(
      context,
      PassengerNoteResult(value == null || value.isEmpty ? null : value),
    );
  }

  void _clear() {
    Navigator.pop(context, const PassengerNoteResult(null));
  }

  @override
  Widget build(BuildContext context) {
    final hasNote = widget.initialNote?.trim().isNotEmpty == true;

    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppReactiveTextField.text(
          formGroup: _form,
          formControlName: 'passengerNote',
          title: AppStrings.passengerNoteToDriver,
          hintText: AppStrings.passengerNoteToDriverHint,
          minLines: 3,
          maxLines: 5,
          textInputAction: TextInputAction.newline,
        ),
        AppSpacing.xl.verticalSpace,
        Row(
          children: [
            Expanded(
              child: AppButton.outline(
                variant: AppButtonVariant.grey,
                isActive: hasNote,
                onTap: _clear,
                child: AppButtonChild.label(AppStrings.passengerNoteClear),
              ),
            ),
            AppSpacing.md.horizontalSpace,
            Expanded(
              child: AppButton.primaryGradient(
                onTap: _save,
                child: AppButtonChild.label(AppStrings.passengerNoteSave),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
