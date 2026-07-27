import 'dart:math' as math;

import 'package:customertaxi/common/imports/imports.dart';

/// What the ring around the status banner's leading chip is saying.
enum TripStatusIndicatorMode {
  /// Still looking for a driver — a sweeping arc orbits the chip.
  searching,

  /// A driver was found — the ring closes and a check badge lands on it.
  done,
}

/// A thin progress ring drawn *around* the status banner's leading chip.
///
/// Deliberately not a [CircularProgressIndicator]: that reads as a generic
/// "loading" spinner, and this is a status story — the same ring sweeps while
/// we search and then closes into a tick the moment a driver is assigned, so the
/// two states feel like one continuous object rather than two widgets swapping.
/// Painted in [AppColors.success] regardless of the surrounding trip accent,
/// because green is the app's "this is going well" colour.
class TripStatusIndicator extends StatefulWidget {
  const TripStatusIndicator({
    required this.mode,
    required this.size,
    required this.child,
    super.key,
  });

  final TripStatusIndicatorMode mode;

  /// Outer diameter of the ring. [child] is centred inside it.
  final double size;

  final Widget child;

  @override
  State<TripStatusIndicator> createState() => _TripStatusIndicatorState();
}

class _TripStatusIndicatorState extends State<TripStatusIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1200),
  );

  @override
  void initState() {
    super.initState();
    _syncAnimation();
  }

  @override
  void didUpdateWidget(TripStatusIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.mode != widget.mode) _syncAnimation();
  }

  /// The controller only spins while searching; once a driver is found it is
  /// parked so the closed ring holds still under the check badge.
  void _syncAnimation() {
    if (widget.mode == TripStatusIndicatorMode.searching) {
      _controller.repeat();
    } else {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isSearching = widget.mode == TripStatusIndicatorMode.searching;
    final stroke = 2.5.r;

    final ring = SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _controller,
            builder: (context, _) => CustomPaint(
              size: Size.square(widget.size),
              painter: _RingPainter(
                // A full ring once found; a 270° arc while it orbits.
                sweep: isSearching ? math.pi * 1.5 : math.pi * 2,
                rotation: isSearching ? _controller.value * math.pi * 2 : 0,
                stroke: stroke,
              ),
            ),
          ),
          widget.child,
        ],
      ),
    );

    if (isSearching) {
      // Slow breath so the chip feels alive even on a still map.
      return ring
          .animate(onPlay: (c) => c.repeat(reverse: true))
          .scaleXY(
            begin: 1,
            end: 1.06,
            duration: 1200.ms,
            curve: Curves.easeInOut,
          );
    }

    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        ring,
        Positioned(
          right: -2.r,
          bottom: -2.r,
          child:
              Container(
                    padding: REdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      color: AppColors.success,
                      shape: BoxShape.circle,
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.check,
                      size: 8.r,
                      color: Colors.white,
                    ),
                  )
                  .animate()
                  .fadeIn(duration: 250.ms)
                  .scaleXY(
                    begin: 0.6,
                    end: 1,
                    duration: 300.ms,
                    curve: Curves.easeOutBack,
                  ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({
    required this.sweep,
    required this.rotation,
    required this.stroke,
  });

  /// Arc length in radians.
  final double sweep;

  /// Where the arc starts, in radians.
  final double rotation;

  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final radius = (size.width - stroke) / 2;
    final rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: radius,
    );

    // Faint full-circle track, so the moving arc reads as travelling along
    // something rather than floating.
    canvas.drawCircle(
      rect.center,
      radius,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..color = AppColors.success.withValues(alpha: 0.18),
    );

    canvas.drawArc(
      rect,
      -math.pi / 2 + rotation,
      sweep,
      false,
      Paint()
        ..style = PaintingStyle.stroke
        ..strokeWidth = stroke
        ..strokeCap = StrokeCap.round
        ..color = AppColors.success,
    );
  }

  @override
  bool shouldRepaint(_RingPainter oldDelegate) =>
      oldDelegate.sweep != sweep ||
      oldDelegate.rotation != rotation ||
      oldDelegate.stroke != stroke;
}
