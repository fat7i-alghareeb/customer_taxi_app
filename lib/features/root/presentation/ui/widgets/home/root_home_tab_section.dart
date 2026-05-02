import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';
import 'package:customertaxi/features/order/presentation/ui/widgets/order_body.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/root/presentation/states/root_bloc.dart';

import '../map/root_map_loading_section.dart';
import '../map/root_map_section.dart';
import 'root_header_search_pill_widget.dart';

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
          success: (location) => Stack(
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
                    previous.sheetMode != current.sheetMode,
                builder: (context, orderState) {
                  if (orderState.sheetMode != OrderSheetMode.collapsed) {
                    return const SizedBox.shrink();
                  }

                  return RootHeaderSearchPillWidget(
                    onSearchTap: () {
                      context.read<OrderBloc>().add(
                        const OrderEvent.orderNowPressed(),
                      );
                    },
                  );
                },
              ),
              const OrderBody(),
            ],
          ),
        );
      },
    );
  }
}
