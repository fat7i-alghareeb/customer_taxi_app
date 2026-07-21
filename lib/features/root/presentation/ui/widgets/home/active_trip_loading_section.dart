import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/root/presentation/states/root_bloc.dart';

import '../map/root_map_loading_section.dart';
import '../map/root_map_section.dart';

/// Shown by [ActiveTripGate] while it's resolving whether the passenger has
/// an active trip — on cold start, and (mainly) right after a booking
/// succeeds while the backend confirms and the live trip view spins up.
///
/// Deliberately just the bare map: no card, no copy, no booking overlays. The
/// map is what both the Home tab and the live trip view show underneath, so
/// keeping it on screen makes the hand-off seamless instead of flashing a
/// loading state between two map screens.
class ActiveTripLoadingSection extends StatelessWidget {
  const ActiveTripLoadingSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(
      buildWhen: (previous, current) =>
          previous.mapBootstrapState != current.mapBootstrapState,
      builder: (context, state) {
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
          success: (location) => RootMapSection(initialLocation: location),
        );
      },
    );
  }
}
