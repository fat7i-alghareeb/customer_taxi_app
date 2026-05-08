import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customertaxi/common/widgets/custom_scaffold/app_scaffold.dart';
import 'package:customertaxi/core/injection/injectable.dart';
import 'package:customertaxi/features/order/presentation/states/order_bloc.dart';
import 'package:customertaxi/features/root/presentation/states/root_bloc.dart';

import '../../../../../utils/helpers/colored_print.dart';
import '../widgets/root_body.dart';
import '../widgets/root_drawer_content.dart';

class RootScreen extends StatefulWidget {
  const RootScreen({super.key});
  static const String pagePath = '/root_screen';
  static const String pageName = 'RootScreen';

  @override
  State<RootScreen> createState() => _RootScreenState();
}

class _RootScreenState extends State<RootScreen> {
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
      child: AppScaffold.body(
        scaffoldConfig: const AppScaffoldConfig(
          safeArea: [],
          resizeToAvoidBottomInset: false,
        ),
        enableLeadingDrawer: true,
        drawer: const RootDrawerContent(),
        child: const RootBody(),
      ),
    );
  }
}
