import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/trip_status_banner.dart';

/// Full-screen "thank you" overlay shown while a trip is
/// `TripStatus.completed` and not yet rated. Sits on top of the map and the
/// receipt sheet; only the close button ([onClose]) dismisses it (back button
/// blocked), revealing the already-rendered `TripCompletedStatusSheet`
/// underneath.
class TripCompletedOverlay extends StatelessWidget {
  const TripCompletedOverlay({required this.onClose, super.key});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(Assets.images.tripsStatusImage.path, fit: BoxFit.cover),
          Container(color: Colors.black.withValues(alpha: 0.15)),
          Positioned(
            left: 12.w,
            top: MediaQuery.paddingOf(context).top + AppSpacing.sm.h,
            child: AppButton.grey(
              noShadow: true,
              layout: const AppButtonLayout(
                shape: AppButtonShape.circle,
                height: 42,
              ),
              child: AppButtonChild.icon(
                IconSource.icon(Icons.close),
                size: 18,
              ),
              onTap: onClose,
            ),
          ),
          Positioned(
            left: AppSpacing.lg.w,
            top: 0,
            bottom: 0,
            child: Align(
              alignment: Alignment.centerLeft,
              child: TripStatusOverlayCard(
                icon: FontAwesomeIcons.carSide,
                highlightBrand: true,
                title: AppStrings.activeTripCompletedSafetyTitle,
                bodyLines: [
                  AppStrings.activeTripCompletedThankYou,
                  AppStrings.activeTripCompletedSeeYouSoon,
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
