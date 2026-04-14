import 'package:customertaxi/common/imports/imports.dart';

import '../../../../constants/order_constants.dart';
import '../../../states/order_bloc.dart';
import 'order_collapsed_sheet_widget.dart';
import 'order_expanded_sheet_widget.dart';
import 'order_map_pick_sheet_widget.dart';

class OrderSheetSection extends StatelessWidget {
  const OrderSheetSection({super.key, required this.state});

  final OrderState state;

  double _resolveSheetVerticalPadding() {
    switch (state.sheetMode) {
      case OrderSheetMode.collapsed:
        return OrderConstants.collapsedSheetVerticalPadding;
      case OrderSheetMode.expanded:
      case OrderSheetMode.mapPicking:
        return AppSpacing.md;
    }
  }

  double _resolveSheetHeight(BuildContext context) {
    switch (state.sheetMode) {
      case OrderSheetMode.collapsed:
        return OrderConstants.collapsedSheetHeight.h;
      case OrderSheetMode.expanded:
        return context.screenHeight;
      case OrderSheetMode.mapPicking:
        return OrderConstants.mapPickSheetHeight.h;
    }
  }

  Widget _resolveSheetContent(BuildContext context) {
    switch (state.sheetMode) {
      case OrderSheetMode.collapsed:
        return const OrderCollapsedSheetWidget();
      case OrderSheetMode.expanded:
        return OrderExpandedSheetWidget(state: state);
      case OrderSheetMode.mapPicking:
        return OrderMapPickSheetWidget(state: state);
    }
  }

  BoxDecoration _resolveSheetDecoration(BuildContext context) {
    switch (state.sheetMode) {
      case OrderSheetMode.collapsed:
        return BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 20,
              offset: const Offset(0, -10),
            ),
          ],
        );
      case OrderSheetMode.expanded:
        return BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: context.shadows.grey,
        );
      case OrderSheetMode.mapPicking:
        return BoxDecoration(
          color: context.surface,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: context.shadows.grey,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    printC('[OrderSheetSection] build mode=${state.sheetMode.name}');
    return AnimatedContainer(
      duration: AppDurations.slow,
      curve: Curves.easeInOut,
      padding: REdgeInsets.symmetric(vertical: _resolveSheetVerticalPadding()),
      width: double.maxFinite,
      height: _resolveSheetHeight(context),
      decoration: _resolveSheetDecoration(context),
      child: AnimatedSwitcher(
        duration: AppDurations.slow,
        switchInCurve: Curves.easeOutQuart,
        switchOutCurve: Curves.easeInQuart,
        transitionBuilder: (child, animation) {
          final slide = Tween<Offset>(
            begin: const Offset(0, 0.04),
            end: Offset.zero,
          ).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.easeOutQuart,
            ),
          );

          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: slide,
              child: child,
            ),
          );
        },
        child: KeyedSubtree(
          key: ValueKey<String>('order-sheet-${state.sheetMode.name}'),
          child: _resolveSheetContent(context).standardHorizontalPadding,
        ),
      ),
    );
  }
}
