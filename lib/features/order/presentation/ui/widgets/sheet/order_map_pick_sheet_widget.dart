import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customertaxi/common/imports/imports.dart';

import '../../../states/order_bloc.dart';

class OrderMapPickSheetWidget extends StatelessWidget {
  const OrderMapPickSheetWidget({super.key, required this.state});

  final OrderState state;

  @override
  Widget build(BuildContext context) {
    final selectingLabel = switch (state.mapPickingTarget) {
      OrderLocationTarget.from => AppStrings.from,
      OrderLocationTarget.to => AppStrings.to,
      OrderLocationTarget.pickupPoint => AppStrings.pickupPoint,
    };

    return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: REdgeInsets.all(AppSpacing.xs),
                  decoration: BoxDecoration(
                    color: context.primary.withValues(alpha: 0.08),
                    shape: BoxShape.circle,
                  ),
                  child: FaIcon(
                    FontAwesomeIcons.crosshairs,
                    size: 14.r,
                    color: context.primary,
                  ),
                ).animate().fadeIn(delay: 100.ms).scale(),
                AppSpacing.sm.horizontalSpace,
                Expanded(
                  child: Text(
                    '${AppStrings.setOnMap} $selectingLabel',
                    style: AppTextStyles.s14w600.copyWith(
                      color: context.onSurface,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ).animate().fadeIn(delay: 200.ms).slideX(begin: 0.05),
              ],
            ),
            AppSpacing.xl.verticalSpace,
            Row(
              children: [
                Expanded(
                  child: AppButton.grey(
                    onTap: () {
                      printM(
                        '[OrderMapPickSheetWidget] cancel map pick tapped',
                      );
                      context.read<OrderBloc>().add(
                        const OrderEvent.mapPickCancelled(),
                      );
                    },
                    layout: AppButtonLayout(
                      height: 48.sp,
                      borderRadius: AppRadii.lg,
                    ),
                    child: AppButtonChild.label(AppStrings.cancel),
                  ),
                ).animate().fadeIn(delay: 300.ms).slideY(begin: 0.2),
                AppSpacing.sm.horizontalSpace,
                Expanded(
                      child: AppButton.primary(
                        onTap: () {
                          printC(
                            '[OrderMapPickSheetWidget] confirm point tapped',
                          );
                          context.read<OrderBloc>().add(
                            const OrderEvent.confirmMapPointPressed(),
                          );
                        },
                        layout: AppButtonLayout(
                          height: 48.sp,
                          borderRadius: AppRadii.lg,
                        ),
                        child: AppButtonChild.label(AppStrings.confirmPoint),
                      ),
                    )
                    .animate()
                    .fadeIn(delay: 400.ms)
                    .slideY(begin: 0.2)
                    .then(delay: 1000.ms)
                    .shimmer(
                      duration: 1500.ms,
                      color: context.onPrimary.withValues(alpha: 0.2),
                    ),
              ],
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 400.ms)
        .slideY(begin: 0.1, end: 0, curve: Curves.easeOutQuart);
  }
}
