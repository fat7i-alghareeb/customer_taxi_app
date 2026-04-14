import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customertaxi/core/injection/injectable.dart';
import 'package:customertaxi/utils/helpers/colored_print.dart';
import '../../states/order_bloc.dart';

import '../widgets/order_body.dart';

class OrderView extends StatelessWidget {
  const OrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        printC('[OrderView] creating OrderBloc and dispatching started');
        return getIt<OrderBloc>()..add(const OrderEvent.started());
      },
      child: const OrderBody(),
    );
  }
}
