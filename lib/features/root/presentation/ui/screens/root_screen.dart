import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:customertaxi/core/injection/injectable.dart';
import 'package:customertaxi/core/services/app_version/app_version_gate_coordinator.dart';
import 'package:customertaxi/features/app_update/presentation/ui/widgets/soft_update_sheet.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';
import 'package:customertaxi/features/root/presentation/states/root_bloc.dart';

import '../../../../../utils/helpers/colored_print.dart';
import '../widgets/root_body.dart';


class RootScreen extends StatefulWidget {
  const RootScreen({super.key, this.initialTab});
  static const String pagePath = '/root_screen';
  static const String pageName = 'RootScreen';

  final RootTab? initialTab;

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
  @override
  void initState() {
    super.initState();
    // Fired from Root's own first frame rather than from the coordinator: this
    // widget is guaranteed mounted here, so there is no race with the router
    // still settling and no reliance on a navigator-key context that a pending
    // redirect might replace. Showing a sheet is not navigation, so the
    // "no manual navigation during bootstrap" rule is untouched.
    WidgetsBinding.instance.addPostFrameCallback((_) => _maybeShowSoftUpdate());
  }

  Future<void> _maybeShowSoftUpdate() async {
    final coordinator = getIt<AppVersionGateCoordinator>();
    if (!coordinator.isSoftUpdateAvailable || coordinator.hasShownSoftUpdate) {
      return;
    }

    // Latch before awaiting so a rebuild cannot double-fire the sheet. The latch
    // is in-memory, so the prompt returns on the next cold start.
    coordinator.markSoftUpdateShown();
    printM('[RootScreen] showing soft update sheet');

    if (!mounted) return;
    await showSoftUpdateSheet(context);
  }

  @override
  Widget build(BuildContext context) {
    printM('[RootScreen] build');
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              getIt<RootBloc>()..add(const RootEvent.started()),
        ),
        BlocProvider(
          create: (context) =>
              getIt<OrderBloc>()..add(const OrderEvent.started()),
        ),
      ],
      child: RootBody(initialTab: widget.initialTab),
    );
  }
}
