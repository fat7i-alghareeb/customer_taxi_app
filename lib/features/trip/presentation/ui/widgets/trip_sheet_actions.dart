import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_cancel_button.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_chat_button.dart';

/// Chat + Cancel on a single row, shared by the confirmation, en-route and
/// arrived sheets. Chat takes twice the width (`flex: 2`) of Cancel and both
/// match the taller one's height. When [showCancel] is false it degrades to a
/// full-width chat button (chat always shows; cancel only when cancellable).
class TripSheetActions extends StatelessWidget {
  const TripSheetActions({
    required this.showCancel,
    required this.cancelIsLoading,
    required this.onCancelPressed,
    super.key,
  });

  final bool showCancel;
  final bool cancelIsLoading;
  final VoidCallback onCancelPressed;

  @override
  Widget build(BuildContext context) {
    if (!showCancel) return const TripChatButton();
    return IntrinsicHeight(
      child: Row(
        // Stretch so the shorter Cancel button grows to the Chat card's height.
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Expanded(flex: 2, child: TripChatButton()),
          AppSpacing.sm.horizontalSpace,
          Expanded(
            child: TripCancelButton(
              isLoading: cancelIsLoading,
              onTap: onCancelPressed,
            ),
          ),
        ],
      ),
    );
  }
}
