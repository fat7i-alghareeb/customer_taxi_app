import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';

import '../../states/order_bloc.dart';
import 'sheet/order_center_pin_widget.dart';
import 'sheet/order_sheet_section.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrderBloc, OrderState>(
      listenWhen: (previous, current) =>
          previous.sheetMode != current.sheetMode ||
          previous.tripRequestStatus != current.tripRequestStatus,
      listener: (context, state) {
        printM('[OrderBody] sheetMode=${state.sheetMode.name}');

        state.tripRequestStatus.when(
          initial: () {},
          loading: () {},
          success: (trip) {
            showSuccessOverlay(context, AppStrings.orderConfirmedSuccess);
            context.read<OrderBloc>().add(const OrderEvent.collapseRequested());
          },
          failure: (message) {
            showErrorOverlay(context, message);
          },
        );
      },
      buildWhen: (previous, current) {
        final shouldBuild = previous.sheetMode != current.sheetMode ||
            previous.expandedStep != current.expandedStep ||
            previous.mapPickingTarget != current.mapPickingTarget ||
            previous.stops != current.stops ||
            previous.stopSuggestionsState != current.stopSuggestionsState ||
            previous.tripRouteState != current.tripRouteState ||
            previous.tripCarOptionsState != current.tripCarOptionsState ||
            previous.selectedCarTypeId != current.selectedCarTypeId ||
            previous.scheduleMode != current.scheduleMode ||
            previous.scheduledAt != current.scheduledAt ||
            previous.paymentMethodId != current.paymentMethodId;
        
        if (shouldBuild) {
          printC('[OrderBody] buildWhen -> true (state changed)');
        }
        return shouldBuild;
      },
      builder: (context, state) {
        printC('[OrderBody] builder rendering sheetMode=${state.sheetMode.name}');
        return PopScope(
          canPop: state.sheetMode == OrderSheetMode.collapsed,
          onPopInvokedWithResult: (_, _) {
            if (state.sheetMode != OrderSheetMode.collapsed) {
              if (state.sheetMode == OrderSheetMode.mapPicking) {
                printM('[OrderBody] system back -> mapPickCancelled');
                context.read<OrderBloc>().add(
                  const OrderEvent.mapPickCancelled(),
                );
                return;
              }

              if (state.sheetMode == OrderSheetMode.expanded &&
                  state.expandedStep == OrderExpandedStep.bookingDetails) {
                printM('[OrderBody] system back -> bookingDetailsBackPressed');
                context.read<OrderBloc>().add(
                  const OrderEvent.bookingDetailsBackPressed(),
                );
                return;
              }

              if (state.sheetMode == OrderSheetMode.expanded &&
                  state.expandedStep == OrderExpandedStep.carSelection) {
                printM('[OrderBody] system back -> vehicleStepBackPressed');
                context.read<OrderBloc>().add(
                  const OrderEvent.vehicleStepBackPressed(),
                );
                return;
              }

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
              if (state.sheetMode != OrderSheetMode.collapsed)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: REdgeInsets.only(
                      bottom:
                          context.bottomPadding +
                          (state.sheetMode == OrderSheetMode.expanded &&
                                  state.expandedStep ==
                                      OrderExpandedStep.carSelection
                              ? context.bottomInset
                              : 0),
                    ),
                    child: OrderSheetSection(state: state),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}
