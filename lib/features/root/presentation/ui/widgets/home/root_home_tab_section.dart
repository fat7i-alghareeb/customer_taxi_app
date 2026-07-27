import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';
import 'package:customertaxi/features/order/presentation/ui/widgets/order_body.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/root/presentation/states/root_bloc.dart';

import 'package:customertaxi/features/root/constants/root_constants.dart';
import '../map/root_map_loading_section.dart';
import '../map/root_map_section.dart';
import 'reserved_trips_banner.dart';
import 'root_home_bottom_sheet.dart';

class RootHomeTabSection extends StatelessWidget {
  const RootHomeTabSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(
      buildWhen: (previous, current) =>
          previous.mapBootstrapState != current.mapBootstrapState,
      builder: (context, state) {
        printM(
          '[RootHomeTabSection] mapBootstrapState=${state.mapBootstrapState.runtimeType}',
        );
        return StatusBuilder<RootMapLocationEntity>(
          state: state.mapBootstrapState,
          errorMessage: AppStrings.rootMapInitializationFailed,
          init: () => const RootMapLoadingSection(),
          loading: () => const RootMapLoadingSection(),
          onError: () {
            context.read<RootBloc>().add(
              const RootEvent.mapBootstrapRequested(),
            );
          },
          success: (location) {
            printG(
              '[RootHomeTabSection] StatusBuilder success location=(${location.latitude},${location.longitude})',
            );
            return Stack(
              fit: StackFit.expand,
              children: [
                RootMapSection(
                  initialLocation: location,
                  onCameraIdleLocationChanged: (target) {
                    context.read<OrderBloc>().add(
                      OrderEvent.mapCameraTargetUpdated(
                        latitude: target.latitude,
                        longitude: target.longitude,
                        zoom: target.zoom,
                      ),
                    );
                  },
                ),
                BlocBuilder<OrderBloc, OrderState>(
                  buildWhen: (previous, current) =>
                      previous.sheet.mode != current.sheet.mode ||
                      previous.trip.carOptionsState != current.trip.carOptionsState,
                  builder: (context, orderState) {
                    if (orderState.sheet.mode != OrderSheetMode.collapsed) {
                      return const SizedBox.shrink();
                    }
                    
                    final discountPercent = orderState.trip.carOptionsState.maybeWhen(
                      success: (opts) => opts.isNotEmpty ? opts.first.discountPercent : 0.0,
                      orElse: () => 5.0, // Forced to 5.0 so the banner is visible
                    );
                    
                    return _HomeCollapsedOverlay(discountPercent: discountPercent);
                  },
                ),
                const OrderBody(),
              ],
            );
          },
        );
      },
    );
  }
}

class _HomeCollapsedOverlay extends StatelessWidget {
  const _HomeCollapsedOverlay({this.discountPercent = 0.0});

  final double discountPercent;

  void _openNow(BuildContext context) {
    context.read<OrderBloc>().add(const OrderEvent.orderNowPressed());
  }

  void _openLater(BuildContext context) {
    context.read<OrderBloc>().add(
      const OrderEvent.orderNowPressed(mode: OrderScheduleMode.later),
    );
  }

  void _openDrawer(BuildContext context) {
    Scaffold.maybeOf(context)?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Align(
          alignment: AlignmentDirectional.topStart,
          child: SafeArea(
            child: Padding(
              padding: REdgeInsets.all(AppSpacing.md),
              child: Row(
                children: [
                  AppButton.variant(
                    variant: AppButtonVariant.grey,
                    fill: AppButtonFill.solid,
                    onTap: () => _openDrawer(context),
                    layout: AppButtonLayout(
                      shape: AppButtonShape.circle,
                      height: RootConstants.headerMenuSize.sp,
                      backgroundColor: context.surface,
                      contentPadding: REdgeInsets.all(AppSpacing.sm),
                    ),
                    customShadows: context.shadows.grey,
                    child: AppButtonChild.custom(
                      FaIcon(
                        FontAwesomeIcons.bars,
                        size: 18.r,
                        color: context.onSurface,
                      ),
                    ),
                  ),
                  // Future reservations no longer take over the Home tab, so
                  // this pill is the only place they surface while booking.
                  const Expanded(child: ReservedTripsBanner()),
                ],
              ),
            ),
          ),
        ),
        RootHomeBottomSheet(
          discountPercent: discountPercent,
          onSearchTap: () => _openNow(context),
          onLaterTap: () => _openLater(context),
        ),
      ],
    );
  }
}
