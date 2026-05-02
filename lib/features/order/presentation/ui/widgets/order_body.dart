import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/common/widgets/show_overlay.dart';
import 'package:customertaxi/core/utils/bloc_status.dart';

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
          previous.pickupConfirmationFeedbackState !=
              current.pickupConfirmationFeedbackState,
      listener: (context, state) {
        printM('[OrderBody] sheetMode=${state.sheetMode.name}');

        state.pickupConfirmationFeedbackState.when(
          initial: () {},
          loading: () {},
          success: (message) {
            if (message.trim().isEmpty) {
              return;
            }

            showSuccessOverlay(context, message);
            context.read<OrderBloc>().add(
              const OrderEvent.pickupConfirmationFeedbackCleared(),
            );
          },
          failure: (message) {
            if (message.trim().isEmpty) {
              return;
            }

            showErrorOverlay(context, message);
            context.read<OrderBloc>().add(
              const OrderEvent.pickupConfirmationFeedbackCleared(),
            );
          },
        );
      },
      buildWhen: (previous, current) {
        return previous.sheetMode != current.sheetMode ||
            previous.expandedStep != current.expandedStep ||
            previous.mapPickingTarget != current.mapPickingTarget ||
            previous.fromLocationState != current.fromLocationState ||
            previous.toLocationState != current.toLocationState ||
            previous.pickupPointState != current.pickupPointState ||
            previous.fromSuggestionsState != current.fromSuggestionsState ||
            previous.toSuggestionsState != current.toSuggestionsState ||
            previous.pickupStreetName != current.pickupStreetName ||
            previous.pickupHouseNumber != current.pickupHouseNumber ||
            previous.tripRouteState != current.tripRouteState ||
            previous.tripCarOptionsState != current.tripCarOptionsState ||
            previous.selectedCarTypeId != current.selectedCarTypeId ||
            previous.scheduledAt != current.scheduledAt ||
            previous.paymentMethodId != current.paymentMethodId;
      },
      builder: (context, state) {
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
                  state.expandedStep == OrderExpandedStep.pickupPoint) {
                printM('[OrderBody] system back -> pickupPointBackPressed');
                context.read<OrderBloc>().add(
                  const OrderEvent.pickupPointBackPressed(),
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
                                  (state.expandedStep ==
                                          OrderExpandedStep.pickupPoint ||
                                      state.expandedStep ==
                                          OrderExpandedStep.carSelection)
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
