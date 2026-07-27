import 'package:flutter/gestures.dart';

import 'package:customertaxi/common/imports/imports.dart';

class ConsentCheckbox extends StatelessWidget {
  const ConsentCheckbox({
    super.key,
    required this.formControlName,
    required this.prefixLabel,
    required this.linkLabel,
    required this.onLinkTap,
    this.suffixLabel,
  });

  final String formControlName;
  final String prefixLabel;
  final String linkLabel;

  /// Trailing text after the link. Needed because not every language puts the
  /// verb before the object — Dutch reads "Ik heb het `Privacybeleid` gelezen",
  /// German "Ich stimme den `AGB` zu". Empty in languages that don't need it.
  final String? suffixLabel;

  final VoidCallback onLinkTap;

  @override
  Widget build(BuildContext context) {
    return ReactiveValueListenableBuilder<bool>(
      formControlName: formControlName,
      builder: (context, control, _) {
        final value = control.value ?? false;
        return InkWell(
          onTap: () => control.value = !value,
          borderRadius: BorderRadius.circular(AppRadii.sm.r),
          child: Padding(
            padding: REdgeInsets.symmetric(vertical: AppSpacing.xs),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 24.r,
                  width: 24.r,
                  child: Checkbox(
                    value: value,
                    onChanged: (next) => control.value = next ?? false,
                    activeColor: context.primary,
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    visualDensity: VisualDensity.compact,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadii.xs.r),
                    ),
                  ),
                ),
                AppSpacing.md.horizontalSpace,
                Expanded(
                  child: Padding(
                    padding: REdgeInsets.only(top: 2),
                    child: RichText(
                      text: TextSpan(
                        style: AppTextStyles.s14w400.copyWith(
                          color: context.onSurface,
                          height: 1.4,
                        ),
                        children: [
                          TextSpan(text: prefixLabel),
                          TextSpan(
                            text: linkLabel,
                            style: AppTextStyles.s14w600.copyWith(
                              color: context.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: context.primary,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = onLinkTap,
                          ),
                          if (suffixLabel case final suffix?
                              when suffix.isNotEmpty)
                            TextSpan(text: suffix),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
