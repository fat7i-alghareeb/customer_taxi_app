import 'package:customertaxi/common/imports/imports.dart';

class RootMapRecenterButtonWidget extends StatelessWidget {
  const RootMapRecenterButtonWidget({
    super.key,
    required this.onTap,
    required this.isLoading,
  });

  final VoidCallback onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AppButton.primary(
      onTap: onTap,
      // isLoading: isLoading,
      layout: AppButtonLayout(
        borderRadius: AppRadii.md,
        height: 40,
        width: 40,
        contentPadding: REdgeInsets.all(AppSpacing.sm),
      ),
      child: AppButtonChild.icon(
        IconSource.builder(
          (context) => FaIcon(FontAwesomeIcons.locationCrosshairs, size: 16.r),
        ),
      ),
    );
  }
}
