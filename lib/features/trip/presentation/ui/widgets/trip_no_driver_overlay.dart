import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_status_banner.dart';

/// Full-screen BLOCKING overlay shown when the backend reports that no driver
/// was found for a pending trip. There is no close button — the user must
/// choose to postpone the search (40 min) or cancel (full refund). Once the
/// no-driver cancel succeeds it swaps to an apology confirmation with a Done
/// action.
///
/// Visibility is owned by the host (driven by `trip.noDriverDecisionRequired`);
/// this widget is a pure function of its props — the prompt→apology phase is
/// derived from [cancelStatus] so it needs no internal state.
class TripNoDriverOverlay extends StatelessWidget {
  const TripNoDriverOverlay({
    required this.postponeStatus,
    required this.cancelStatus,
    required this.onPostpone,
    required this.onCancel,
    required this.onDone,
    super.key,
  });

  final BlocStatus<void> postponeStatus;
  final BlocStatus<void> cancelStatus;
  final VoidCallback onPostpone;
  final VoidCallback onCancel;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final showApology = cancelStatus.isSuccess;

    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(Assets.images.tripsStatusImage.path, fit: BoxFit.cover),
        Container(color: Colors.black.withValues(alpha: 0.35)),
        Positioned(
          left: AppSpacing.lg.w,
          top: 0,
          bottom: 0,
          child: Align(
            alignment: Alignment.centerLeft,
            child: Directionality(
              textDirection: TextDirection.ltr,
              child: SizedBox(
                width: 260.w,
                child: showApology ? _buildApology() : _buildPrompt(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPrompt() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TripStatusOverlayCard(
          icon: FontAwesomeIcons.carSide,
          title: AppStrings.noDriverFoundTitle,
          bodyLines: [AppStrings.noDriverFoundBody],
        ),
        AppSpacing.lg.verticalSpace,
        AppButton.primaryGradient(
          isLoading: postponeStatus.isLoading,
          onTap: onPostpone,
          child: AppButtonChild.label(AppStrings.noDriverPostponeButton),
        ),
        AppSpacing.md.verticalSpace,
        AppButton.grey(
          isLoading: cancelStatus.isLoading,
          onTap: onCancel,
          child: AppButtonChild.label(AppStrings.tripCancelButton),
        ),
      ],
    );
  }

  Widget _buildApology() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TripStatusOverlayCard(
          icon: FontAwesomeIcons.circleCheck,
          title: AppStrings.noDriverCancelledTitle,
          bodyLines: [AppStrings.noDriverCancelledBody],
        ),
        AppSpacing.lg.verticalSpace,
        AppButton.primaryGradient(
          onTap: onDone,
          child: AppButtonChild.label(AppStrings.done),
        ),
      ],
    );
  }
}
