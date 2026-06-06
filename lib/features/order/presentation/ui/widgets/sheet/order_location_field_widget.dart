import 'package:customertaxi/common/imports/imports.dart';

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
    this.onAddPressed,
    this.onRemovePressed,
    this.focusNode,
  });

  final String formControlName;
  final String title;
  final String hintText;
  final FaIconData iconData;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback? onClearPressed;
  final VoidCallback? onAddPressed;
  final VoidCallback? onRemovePressed;
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
    printM('[OrderLocationFieldWidget] initState controlName=${widget.formControlName}');
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
    printM('[OrderLocationFieldWidget] _onFocusChanged controlName=${widget.formControlName} hasFocus=${_internalFocusNode.hasFocus}');
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
                final showClear = _hasFocus && hasValue && widget.onClearPressed != null;
                final showAdd = widget.onAddPressed != null;
                final showRemove = widget.onRemovePressed != null;

                printM('[OrderLocationFieldWidget] build controlName=${widget.formControlName} value="${control.value}" hasFocus=$_hasFocus');

                Widget? suffixWidget;
                IconSource? suffixIcon;
                VoidCallback? onSuffixTap;

                if (showClear && showAdd) {
                  suffixWidget = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SuffixIconButton(
                        icon: FontAwesomeIcons.xmark,
                        onTap: widget.onClearPressed!,
                      ),
                      AppSpacing.xs.horizontalSpace,
                      _SuffixIconButton(
                        icon: FontAwesomeIcons.plus,
                        color: context.primary,
                        onTap: widget.onAddPressed!,
                      ),
                    ],
                  );
                } else if (showClear && showRemove) {
                  suffixWidget = Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _SuffixIconButton(
                        icon: FontAwesomeIcons.xmark,
                        onTap: widget.onClearPressed!,
                      ),
                      AppSpacing.xs.horizontalSpace,
                      _SuffixIconButton(
                        icon: FontAwesomeIcons.minus,
                        color: context.onSurface.withValues(alpha: 0.5),
                        onTap: widget.onRemovePressed!,
                      ),
                    ],
                  );
                } else if (showRemove) {
                  suffixWidget = _SuffixIconButton(
                    icon: FontAwesomeIcons.minus,
                    color: context.onSurface.withValues(alpha: 0.5),
                    onTap: widget.onRemovePressed!,
                  );
                } else if (showClear) {
                  suffixIcon = IconSource.faIcon(FontAwesomeIcons.xmark, size: 14.r);
                  onSuffixTap = widget.onClearPressed;
                } else if (showAdd) {
                  suffixIcon = IconSource.faIcon(FontAwesomeIcons.plus, size: 14.r, color: context.primary);
                  onSuffixTap = widget.onAddPressed;
                }

                return AppReactiveTextField.text(
                  formControlName: widget.formControlName,
                  hintText: widget.hintText,
                  focusNode: _internalFocusNode,
                  suffix: suffixWidget,
                  affixes: suffixIcon != null
                      ? AppAffixes(
                          suffixIcon: suffixIcon,
                          onSuffixTap: onSuffixTap,
                        )
                      : const AppAffixes(),
                  onChangedDebounced: (value, _) {
                    printM('[OrderLocationFieldWidget] onChangedDebounced controlName=${widget.formControlName} value="$value"');
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

class _SuffixIconButton extends StatelessWidget {
  const _SuffixIconButton({
    required this.icon,
    required this.onTap,
    this.color,
  });

  final FaIconData icon;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Padding(
        padding: REdgeInsets.all(AppSpacing.sm),
        child: FaIcon(
          icon,
          size: 16.r,
          color: color ?? context.onSurface.withValues(alpha: 0.5),
        ),
      ),
    );
  }
}
