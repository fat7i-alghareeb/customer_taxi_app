import 'package:customertaxi/common/imports/imports.dart';

import '../../../../constants/forms/order_forms.dart';
import '../../../states/order_bloc.dart';

class OrderPickupPointStepWidget extends StatelessWidget {
  const OrderPickupPointStepWidget({
    super.key,
    required this.state,
    required this.onSetPickupOnMapPressed,
    required this.onPickupStreetChanged,
    required this.onPickupHouseNumberChanged,
  });

  final OrderState state;
  final VoidCallback onSetPickupOnMapPressed;
  final ValueChanged<String> onPickupStreetChanged;
  final ValueChanged<String> onPickupHouseNumberChanged;

  @override
  Widget build(BuildContext context) {
    final pickupLabel = state.pickupPointState.maybeWhen(
      success: (location) => location.label,
      orElse: () => null,
    );

    final hasPickup = pickupLabel?.trim().isNotEmpty ?? false;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          padding: REdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: context.primary.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(AppRadii.lg.r),
            border: Border.all(
              color: hasPickup
                  ? context.primary.withValues(alpha: 0.35)
                  : context.onSurface.withValues(alpha: 0.12),
              width: 1.5.r,
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36.r,
                height: 36.r,
                decoration: BoxDecoration(
                  color: context.primary.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: FaIcon(
                    FontAwesomeIcons.mapPin,
                    size: 14.r,
                    color: context.primary,
                  ),
                ),
              ),
              AppSpacing.sm.horizontalSpace,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppStrings.pickupPoint,
                      style: AppTextStyles.s14w600.copyWith(
                        color: context.primary,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    AppSpacing.xs.verticalSpace,
                    state.pickupPointState.maybeWhen(
                      success: (location) {
                        final primary = location.primaryName ?? location.label;
                        final secondary = location.secondaryAddress;
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              primary,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: AppTextStyles.s14w600.copyWith(
                                color: context.onSurface.withValues(alpha: 0.9),
                                fontWeight: FontWeight.w800,
                              ),
                            ),

                            if ((secondary ?? '').isNotEmpty)
                              Text(
                                secondary!,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: AppTextStyles.s12w400.copyWith(
                                  color:
                                      context.onSurface.withValues(alpha: 0.5),
                                ),
                              ),
                          ],
                        );
                      },
                      orElse: () {
                        return Text(
                          AppStrings.pickupPointNotSelected,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.s12w400.copyWith(
                            color: context.onSurface.withValues(alpha: 0.7),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

            ],
          ),
        ).animate().fadeIn(delay: 120.ms).slideY(begin: 0.06),
        AppSpacing.md.verticalSpace,
        AppButton.success(
          onTap: onSetPickupOnMapPressed,
          layout: AppButtonLayout(height: 48.sp, borderRadius: AppRadii.lg),
          child: AppButtonChild.label(AppStrings.setPickupPointOnMap),
        ).animate().fadeIn(delay: 180.ms).slideY(begin: 0.06),
        AppSpacing.lg.verticalSpace,
        Text(
          AppStrings.pickupDetailsOptional,
          style: AppTextStyles.s14w600.copyWith(
            color: context.primary,
            fontWeight: FontWeight.w800,
          ),
        ).animate().fadeIn(delay: 240.ms),
        AppSpacing.sm.verticalSpace,
        AppReactiveTextField.stringOnly(
          formControlName: OrderForms.pickupStreetField,
          title: AppStrings.pickupStreetName,
          hintText: AppStrings.pickupStreetName,
          onChangedDebounced: (value, _) {
            onPickupStreetChanged(value);
          },
          textInputAction: TextInputAction.next,
        ).animate().fadeIn(delay: 280.ms).slideY(begin: 0.05),
        AppSpacing.md.verticalSpace,
        AppReactiveTextField.integer(
          formControlName: OrderForms.pickupHouseNumberField,
          title: AppStrings.pickupHouseNumber,
          hintText: AppStrings.pickupHouseNumber,
          onChangedDebounced: (value, _) {
            onPickupHouseNumberChanged(value);
          },
          textInputAction: TextInputAction.done,
        ).animate().fadeIn(delay: 340.ms).slideY(begin: 0.05),
      ],
    );
  }
}
