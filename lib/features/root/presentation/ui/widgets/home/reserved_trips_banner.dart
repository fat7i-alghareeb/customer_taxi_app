import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/root_screen.dart';
import 'package:customertaxi/features/root/presentation/ui/widgets/root_body.dart';
import 'package:customertaxi/features/trip/domain/entities/trip_entity.dart';
import 'package:customertaxi/features/trip/presentation/states/active_trip_cubit.dart';
import 'package:customertaxi/features/trip/presentation/ui/screens/active_trip_screen.dart';
import 'package:customertaxi/features/trip/presentation/utils/trip_countdown_format.dart';

/// Compact pill over the map listing the passenger's future reservations.
///
/// Reserved trips no longer take over the Home tab — the booking sheet stays
/// usable — so this is the only place they are visible while booking. Tapping a
/// single reservation opens its trip screen; several open the Trips tab.
class ReservedTripsBanner extends StatelessWidget {
  const ReservedTripsBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ActiveTripCubit, ActiveTripState>(
      builder: (context, state) {
        final reserved = state.reservedTrips;
        if (reserved.isEmpty) return const SizedBox.shrink();

        // Soonest first — the list already arrives ordered by pickup time.
        final next = reserved.first;
        final scheduledAt = next.scheduledAtUtc!.toLocal();
        final label = reserved.length == 1
            ? AppStrings.reservedTripBannerSingle.replaceAll(
                '{time}',
                scheduledAt.toSmartDateTime(),
              )
            : AppStrings.reservedTripBannerMultiple.replaceAll(
                '{count}',
                '${reserved.length}',
              );

        return Padding(
          padding: REdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              borderRadius: BorderRadius.circular(AppRadii.xl.r),
              onTap: () => _open(context, reserved),
              child: Container(
                padding: REdgeInsets.symmetric(
                  horizontal: AppSpacing.md,
                  vertical: AppSpacing.sm,
                ),
                decoration: BoxDecoration(
                  color: context.surface,
                  borderRadius: BorderRadius.circular(AppRadii.xl.r),
                  border: Border.all(
                    color: AppColors.tripOrange.withValues(alpha: 0.35),
                  ),
                  boxShadow: context.shadows.grey,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 28.r,
                      height: 28.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.tripOrange.withValues(alpha: 0.15),
                      ),
                      child: Icon(
                        Icons.event_available_rounded,
                        size: 16.r,
                        color: AppColors.tripOrange,
                      ),
                    ),
                    AppSpacing.sm.horizontalSpace,
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.s12w700.copyWith(
                              color: context.onSurface,
                            ),
                          ),
                          Text(
                            formatStartsIn(next.scheduledAtUtc!),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: AppTextStyles.s11w500.copyWith(
                              color: context.onSurface.withValues(alpha: 0.6),
                            ),
                          ),
                        ],
                      ),
                    ),
                    AppSpacing.xs.horizontalSpace,
                    Icon(
                      Icons.chevron_right_rounded,
                      size: 18.r,
                      color: context.onSurface.withValues(alpha: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ).animate().fadeIn(duration: 300.ms).slideY(begin: -0.3, end: 0);
      },
    );
  }

  void _open(BuildContext context, List<TripEntity> reserved) {
    if (reserved.length == 1) {
      context.pushNamed(ActiveTripScreen.pageName, extra: reserved.first.id);
      return;
    }
    // The tab index is local state inside `RootBody`, so switching tabs from
    // here goes through the route, which already accepts a `RootTab` as extra.
    context.goNamed(RootScreen.pageName, extra: RootTab.trips);
  }
}
