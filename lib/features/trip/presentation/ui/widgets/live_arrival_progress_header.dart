import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/trip/presentation/ui/widgets/live_arrival_overlay.dart';

/// Hero header shown at the top of the en-route status sheet while the driver is
/// heading to the pickup. Mirrors the native tracking card:
///
///   Arrival in            (muted label)
///   5 min                 (large primary number)
///   🚗 ─ ─ ─ ─ ─ ─ ─ ●    (dashed line: car glides left→right toward the pickup dot)
///   2.3 km • 17:08        (muted distance • expected arrival clock)
///
/// Purely presentational. [progress] (0..1) is the share of the journey already
/// covered — fed from the live driver→pickup distance so the car position tracks
/// the driver's real progress, not a timed animation.
class LiveArrivalProgressHeader extends StatelessWidget {
  const LiveArrivalProgressHeader({
    required this.minutes,
    required this.progress,
    this.distanceMeters,
    this.etaSeconds,
    super.key,
  });

  /// Whole minutes until the driver reaches the pickup.
  final int minutes;

  /// Journey completion 0..1 → horizontal position of the car along the line.
  final double progress;

  /// Remaining road distance to pickup, for the subtitle. Null hides the subtitle.
  final int? distanceMeters;

  /// Live ETA in seconds, used to render the expected arrival clock. Null hides it.
  final int? etaSeconds;

  @override
  Widget build(BuildContext context) {
    final colors = context.colorScheme;
    final clampedProgress = progress.isNaN ? 0.0 : progress.clamp(0.0, 1.0);
    final showSubtitle = distanceMeters != null && etaSeconds != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          AppStrings.activeTripArrivalInLabel,
          style: AppTextStyles.s12w500.copyWith(
            color: colors.onSurface.withValues(alpha: 0.55),
          ),
        ),
        AppSpacing.xs.verticalSpace,
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              '$minutes',
              style: AppTextStyles.s28w700.copyWith(color: colors.primary),
            ),
            AppSpacing.xs.horizontalSpace,
            Text(
              'min',
              style: AppTextStyles.s16w600.copyWith(color: colors.primary),
            ),
          ],
        ),
        AppSpacing.md.verticalSpace,
        _ProgressTrack(progress: clampedProgress, color: colors.primary),
        if (showSubtitle) ...[
          AppSpacing.sm.verticalSpace,
          Text(
            '${LiveArrival.distance(distanceMeters!)}  •  ${LiveArrival.arrivalClock(etaSeconds!)}',
            style: AppTextStyles.s12w500.copyWith(
              color: colors.onSurface.withValues(alpha: 0.6),
            ),
          ),
        ],
      ],
    );
  }
}

/// The dashed line with a pickup dot pinned at the end and a car icon that slides
/// from left to right as [progress] grows. The slide is animated between the
/// ~1 Hz location updates so the car glides instead of jumping.
class _ProgressTrack extends StatelessWidget {
  const _ProgressTrack({required this.progress, required this.color});

  final double progress;
  final Color color;

  @override
  Widget build(BuildContext context) {
    // Fixed-width box around the car so it always stays within the track bounds.
    final double carBox = 34.w;

    return SizedBox(
      height: 32.h,
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double maxLeft = (constraints.maxWidth - carBox)
              .clamp(0.0, double.infinity);
          return TweenAnimationBuilder<double>(
            tween: Tween<double>(begin: 0, end: progress),
            duration: const Duration(milliseconds: 900),
            curve: Curves.easeOut,
            builder: (context, value, _) {
              return Stack(
                clipBehavior: Clip.none,
                children: [
                  // Dashed connector running the full width, centred vertically.
                  Positioned.fill(
                    child: CustomPaint(
                      painter: _DashedLinePainter(
                        color: color.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                  // Pickup dot at the end of the line.
                  Positioned(
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Center(
                      child: Container(
                        width: 12.r,
                        height: 12.r,
                        decoration: BoxDecoration(
                          color: color,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: color.withValues(alpha: 0.4),
                              blurRadius: 6.r,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  // The moving car, positioned by real journey progress. Uses the
                  // same real-time car asset as the map marker.
                  Positioned(
                    left: value * maxLeft,
                    top: 0,
                    bottom: 0,
                    width: carBox,
                    child: Center(
                      child: AppImageViewer.asset(
                        Assets.images.carForRealTime.path,
                        width: 40,
                        height: 28,
                        fit: BoxFit.contain,
                        borderRadius: 0,
                        loading: AppImageViewerLoading.none,
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

/// Paints a single horizontal dashed line centred vertically in the given size.
class _DashedLinePainter extends CustomPainter {
  _DashedLinePainter({required this.color});

  final Color color;
  final double dashWidth = 6;
  final double dashGap = 5;
  final double strokeWidth = 2;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final double y = size.height / 2;
    double x = 0;
    while (x < size.width) {
      final double end = (x + dashWidth).clamp(0.0, size.width);
      canvas.drawLine(Offset(x, y), Offset(end, y), paint);
      x += dashWidth + dashGap;
    }
  }

  @override
  bool shouldRepaint(covariant _DashedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
