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
          previous.sheet.mode != current.sheet.mode ||
          previous.booking.tripRequestStatus !=
              current.booking.tripRequestStatus,
      listener: (context, state) {
        printM('[OrderBody] sheetMode=${state.sheet.mode.name}');

        state.booking.tripRequestStatus.when(
          initial: () {},
          loading: () {},
          success: (trip) {
            // Scheduled bookings get the full-screen reservation confirmation
            // instead (raised from the booking handler); a toast underneath it
            // would only flash behind the overlay.
            if (trip.scheduledAtUtc == null) {
              showSuccessOverlay(context, AppStrings.orderConfirmedSuccess);
            }
            context.read<OrderBloc>().add(const OrderEvent.collapseRequested());
          },
          failure: (message) {
            showErrorOverlay(context, message);
          },
        );
      },
      buildWhen: (previous, current) {
        final shouldBuild =
            previous.sheet != current.sheet ||
            previous.stops != current.stops ||
            previous.trip != current.trip ||
            previous.booking != current.booking;

        if (shouldBuild) {
          printC('[OrderBody] buildWhen -> true (slice changed)');
        }
        return shouldBuild;
      },
      builder: (context, state) {
        printC(
          '[OrderBody] builder rendering sheetMode=${state.sheet.mode.name}',
        );
        return PopScope(
          canPop: state.sheet.mode == OrderSheetMode.collapsed,
          onPopInvokedWithResult: (_, _) {
            if (state.sheet.mode == OrderSheetMode.collapsed) return;

            if (state.sheet.mode == OrderSheetMode.mapPicking) {
              printM('[OrderBody] system back -> mapPickCancelled');
              context.read<OrderBloc>().add(
                const OrderEvent.mapPickCancelled(),
              );
              return;
            }

            if (state.sheet.mode == OrderSheetMode.expanded &&
                state.sheet.expandedStep == OrderExpandedStep.bookingDetails) {
              printM('[OrderBody] system back -> bookingDetailsBackPressed');
              context.read<OrderBloc>().add(
                const OrderEvent.bookingDetailsBackPressed(),
              );
              return;
            }

            if (state.sheet.mode == OrderSheetMode.expanded &&
                state.sheet.expandedStep == OrderExpandedStep.carSelection) {
              printM('[OrderBody] system back -> vehicleStepBackPressed');
              context.read<OrderBloc>().add(
                const OrderEvent.vehicleStepBackPressed(),
              );
              return;
            }

            printM('[OrderBody] system back -> collapseRequested');
            context.read<OrderBloc>().add(const OrderEvent.collapseRequested());
          },
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (state.sheet.mode == OrderSheetMode.mapPicking)
                const IgnorePointer(child: OrderCenterPinWidget()),
              if (state.sheet.mode != OrderSheetMode.collapsed)
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: REdgeInsets.only(
                      bottom:
                          context.bottomPadding +
                          (state.sheet.mode == OrderSheetMode.expanded &&
                                  state.sheet.expandedStep ==
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
