import 'package:customertaxi/common/imports/imports.dart';

import '../../../states/order_bloc.dart';
import 'order_expanded_sheet_widget.dart';
import 'order_map_pick_sheet_widget.dart';

class OrderSheetSection extends StatelessWidget {
  const OrderSheetSection({super.key, required this.state});

  final OrderState state;

  double _resolveSheetVerticalPadding() {
    return AppSpacing.md;
  }

  BoxConstraints _resolveSheetConstraints(BuildContext context) {
    if (state.sheetMode == OrderSheetMode.expanded &&
        state.expandedStep == OrderExpandedStep.locationEntry) {
      final verticalPadding = _resolveSheetVerticalPadding();
      final targetHeight =
          context.screenHeight - (verticalPadding * 2) - context.bottomPadding;
      printC('[OrderSheetSection] constraints -> exact $targetHeight');
      return BoxConstraints.tightFor(height: targetHeight);
    }

    if (state.sheetMode == OrderSheetMode.expanded &&
        state.expandedStep == OrderExpandedStep.carSelection) {
      final maxH = context.screenHeight * 0.74;
      printC('[OrderSheetSection] constraints -> maxHeight $maxH');
      return BoxConstraints(maxHeight: maxH);
    }

    printC('[OrderSheetSection] constraints -> unconstrained');
    return const BoxConstraints();
  }

  Widget _resolveSheetContent(BuildContext context) {
    switch (state.sheetMode) {
      case OrderSheetMode.expanded:
        return OrderExpandedSheetWidget(state: state);
      case OrderSheetMode.mapPicking:
        return OrderMapPickSheetWidget(state: state);
      case OrderSheetMode.collapsed:
        return const SizedBox.shrink();
    }
  }

  BoxDecoration _resolveSheetDecoration(BuildContext context) {
    return BoxDecoration(
      color: context.surface,
      borderRadius: BorderRadius.circular(32.r),
      boxShadow: context.shadows.grey,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (state.sheetMode == OrderSheetMode.collapsed) {
      return const SizedBox.shrink();
    }

    printC('[OrderSheetSection] build mode=${state.sheetMode.name}');
    return AnimatedSize(
      duration: AppDurations.slow,
      curve: Curves.easeInOut,
      alignment: Alignment.bottomCenter,
      child: AnimatedContainer(
        duration: AppDurations.slow,
        curve: Curves.easeInOut,
        padding: REdgeInsets.symmetric(
          vertical: _resolveSheetVerticalPadding(),
        ),
        width: double.maxFinite,
        decoration: _resolveSheetDecoration(context),
        child: AnimatedSwitcher(
          duration: AppDurations.slow,
          switchInCurve: Curves.easeOutQuart,
          switchOutCurve: Curves.easeInQuart,
          transitionBuilder: (child, animation) {
            final slide =
                Tween<Offset>(
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
              child: SlideTransition(position: slide, child: child),
            );
          },
          child: KeyedSubtree(
            key: ValueKey<String>('order-sheet-${state.sheetMode.name}'),
            child: ConstrainedBox(
              constraints: _resolveSheetConstraints(context),
              child: _resolveSheetContent(context).standardHorizontalPadding,
            ),
          ),
        ),
      ),
    );
  }
}
