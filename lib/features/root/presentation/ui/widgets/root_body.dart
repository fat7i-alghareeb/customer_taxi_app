import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/domain/entities/root_map_location_entity.dart';
import 'package:customertaxi/features/root/presentation/states/root_bloc.dart';

import 'map/root_map_loading_section.dart';
import 'map/root_map_section.dart';

class RootBody extends StatelessWidget {
  const RootBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RootBloc, RootState>(
      buildWhen: (previous, current) =>
          previous.mapBootstrapState != current.mapBootstrapState,
      builder: (context, state) {
        printM(
          '[RootBody] mapBootstrapState=${state.mapBootstrapState.runtimeType}',
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
          success: (location) => RootMapSection(initialLocation: location),
        );
      },
    );
  }
}
