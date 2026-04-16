import 'package:flutter_animate/flutter_animate.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../../../common/widgets/app_affixes.dart';

class OrderLocationFieldWidget extends StatefulWidget {
  const OrderLocationFieldWidget({
    super.key,
    required this.formControlName,
    required this.title,
    required this.hintText,
    required this.iconData,
    required this.onQueryChanged,
    this.onClearPressed,
    this.focusNode,
  });

  final String formControlName;
  final String title;
  final String hintText;
  final IconData iconData;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback? onClearPressed;
  final FocusNode? focusNode;

  @override
  State<OrderLocationFieldWidget> createState() =>
      _OrderLocationFieldWidgetState();
}

class _OrderLocationFieldWidgetState extends State<OrderLocationFieldWidget> {
  late final FocusNode _internalFocusNode;
  bool _hasFocus = false;

  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    } else {
      _internalFocusNode.removeListener(_onFocusChanged);
    }
    super.dispose();
  }

  void _onFocusChanged() {
    if (mounted) {
      setState(() {
        _hasFocus = _internalFocusNode.hasFocus;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = _hasFocus
        ? context.primary
        : context.colorScheme.outline.withValues(alpha: 0.15);
    final backgroundColor = _hasFocus
        ? context.primary.withValues(alpha: 0.04)
        : context.surface;

    return AnimatedContainer(
      duration: 200.ms,
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppRadii.lg.r),
        border: Border.all(color: borderColor, width: _hasFocus ? 2.0 : 1.5),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                FaIcon(
                  widget.iconData,
                  size: 14.r,
                  color: _hasFocus
                      ? context.primary
                      : context.onSurface.withValues(alpha: 0.5),
                ),
                AppSpacing.xs.horizontalSpace,
                Text(
                  widget.title.toUpperCase(),
                  style: AppTextStyles.s11w500.copyWith(
                    color: _hasFocus
                        ? context.primary
                        : context.onSurface.withValues(alpha: 0.5),
                    fontSize: 10.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.1,
                  ),
                ),
              ],
            ),
            AppSpacing.xs.verticalSpace,
            ReactiveValueListenableBuilder<String>(
              formControlName: widget.formControlName,
              builder: (context, control, _) {
                final hasValue = (control.value ?? '').trim().isNotEmpty;
                final showClear =
                    _hasFocus && hasValue && widget.onClearPressed != null;

                return AppReactiveTextField.text(
                  formControlName: widget.formControlName,
                  hintText: widget.hintText,
                  focusNode: _internalFocusNode,
                  affixes: showClear
                      ? AppAffixes(
                          suffixIcon: IconSource.icon(
                            FontAwesomeIcons.xmark,
                            size: 14.r,
                          ),
                          onSuffixTap: widget.onClearPressed,
                        )
                      : const AppAffixes(),
                  onChangedDebounced: (value, _) {
                    widget.onQueryChanged(value);
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
