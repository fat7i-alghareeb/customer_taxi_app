import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customertaxi/common/imports/imports.dart';

import '../../states/order_bloc.dart';
import 'sheet/order_center_pin_widget.dart';
import 'sheet/order_sheet_section.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listenWhen: (previous, current) =>
          previous.sheetMode != current.sheetMode,
      listener: (context, state) {
        printM('[OrderBody] sheetMode=${state.sheetMode.name}');
      },
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        return PopScope(
          canPop: state.sheetMode == OrderSheetMode.collapsed,
          onPopInvokedWithResult: (_, _) {
            if (state.sheetMode != OrderSheetMode.collapsed) {
              printM('[OrderBody] system back -> collapseRequested');
              context.read<OrderBloc>().add(
                const OrderEvent.collapseRequested(),
              );
            }
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (state.sheetMode == OrderSheetMode.mapPicking)
                const IgnorePointer(child: OrderCenterPinWidget()),
              Align(
                alignment: Alignment.bottomCenter,
                child: OrderSheetSection(state: state),
              ),
            ],
          ),
        );
      },
    );
  }
}
