import 'package:customertaxi/common/imports/imports.dart';

class PaymentSectionHeader extends StatelessWidget {
  const PaymentSectionHeader({super.key, required this.title, this.subtitle});

  final String title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppTextStyles.s18w600.copyWith(color: context.onSurface),
        ),
        if (subtitle != null) ...[
          AppSpacing.xs.verticalSpace,
          Text(
            subtitle!,
            style: AppTextStyles.s12w400.copyWith(
              color: context.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ],
    );
  }
}
