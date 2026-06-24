import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapMarkerGenerator {
  MapMarkerGenerator._();

  static Future<BitmapDescriptor> createCustomMarker({
    required String text,
    required Color color,
    double size = 40,
    bool isEta = false,
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final double radius = size / 2;

    // 1. Draw Shadow
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.2)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 6);
    canvas.drawCircle(Offset(radius, radius + 4), radius - 8, shadowPaint);

    // 2. Draw Circle Background
    final Paint circlePaint = Paint()..color = color;
    canvas.drawCircle(Offset(radius, radius), radius - 8, circlePaint);

    // 3. Draw White Border
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
    canvas.drawCircle(Offset(radius, radius), radius - 8, borderPaint);

    // 4. Draw Text
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    );

    if (isEta) {
      // Split ETA text if it contains "min"
      final parts = text.split(' ');
      final String number = parts.first;
      final String label = parts.length > 1 ? parts.last : '';

      textPainter.text = TextSpan(
        children: [
          TextSpan(
            text: '$number\n',
            style: TextStyle(
              fontSize: size * 0.35,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 0.9,
            ),
          ),
          TextSpan(
            text: label,
            style: TextStyle(
              fontSize: size * 0.18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              height: 1.0,
            ),
          ),
        ],
      );
    } else {
      textPainter.text = TextSpan(
        text: text,
        style: TextStyle(
          fontSize: size * 0.45,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      );
    }

    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset(
        radius - (textPainter.width / 2),
        radius - (textPainter.height / 2),
      ),
    );

    final ui.Image image = await pictureRecorder.endRecording().toImage(
      size.toInt(),
      size.toInt(),
    );
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.bytes(uint8List);
  }

  static Future<BitmapDescriptor> createLabelMarker({
    required String text,
    required Color color,
    double height = 38, // Slightly smaller
    double paddingHorizontal = 12, // More compact
  }) async {
    final TextPainter textPainter = TextPainter(
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
      text: TextSpan(
        text: text,
        style: TextStyle(
          fontSize: height * 0.38,
          fontWeight: FontWeight.bold,
          color: Colors.white,
          letterSpacing: -0.5,
        ),
      ),
    );
    textPainter.layout();

    final double headWidth = textPainter.width + (paddingHorizontal * 2);
    final double tailHeight = 8;
    final double totalHeight = height + tailHeight + 4; // Head + Tail + Shadow buffer
    final double totalWidth = headWidth + 4;

    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);

    // 1. Draw Shadow
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.25)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3);
    
    final Path shadowPath = Path();
    shadowPath.addRRect(RRect.fromLTRBR(2, 2, headWidth + 2, height + 2, Radius.circular(height / 2)));
    // Add tail to shadow
    shadowPath.moveTo(headWidth / 2 - 6 + 2, height + 2);
    shadowPath.lineTo(headWidth / 2 + 2, height + tailHeight + 2);
    shadowPath.lineTo(headWidth / 2 + 6 + 2, height + 2);
    canvas.drawPath(shadowPath, shadowPaint);

    // 2. Draw Pin Shape (Head + Tail)
    final Paint pinPaint = Paint()..color = color;
    final Path pinPath = Path();
    
    // Head (Pill shape)
    pinPath.addRRect(RRect.fromLTRBR(0, 0, headWidth, height, Radius.circular(height / 2)));
    
    // Tail (Triangle)
    pinPath.moveTo(headWidth / 2 - 6, height - 1); // Slight overlap to avoid gap
    pinPath.lineTo(headWidth / 2, height + tailHeight);
    pinPath.lineTo(headWidth / 2 + 6, height - 1);
    
    canvas.drawPath(pinPath, pinPaint);

    // 3. White Border for Contrast
    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    
    canvas.drawPath(pinPath, borderPaint);

    // 4. Draw Text
    textPainter.paint(
      canvas,
      Offset(
        (headWidth - textPainter.width) / 2,
        (height - textPainter.height) / 2,
      ),
    );

    final ui.Image image = await pictureRecorder.endRecording().toImage(
      totalWidth.toInt(),
      totalHeight.toInt(),
    );
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    final Uint8List uint8List = byteData!.buffer.asUint8List();

    return BitmapDescriptor.bytes(uint8List);
  }

  /// Builds the driver's vehicle marker as a pure-vector, top-down car drawn with
  /// [Canvas] (no raster asset). The car points "up" (north); the map marker's
  /// `rotation` is driven by the live bearing so it faces the direction of travel.
  /// Two soft headlight beams fan out from the front, matching the live-tracking UI.
  static Future<BitmapDescriptor> createVehicleMarker({double width = 80}) async {
    final double s = width;
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);

    final double cx = s / 2;
    final double carWidth = s * 0.40;
    final double carLength = s * 0.62;
    final double left = (s - carWidth) / 2;
    final double right = left + carWidth;
    final double top = s * 0.30; // front of the car; beams occupy the space above
    final double bottom = top + carLength;
    final double radius = carWidth * 0.42;

    // 1. Headlight beams — a trapezoid fanning forward from the front of the car,
    //    fading from warm yellow near the bumper to transparent at the tip.
    final Path beam = Path()
      ..moveTo(left + carWidth * 0.18, top)
      ..lineTo(cx - carWidth * 1.05, 0)
      ..lineTo(cx + carWidth * 1.05, 0)
      ..lineTo(right - carWidth * 0.18, top)
      ..close();
    final Paint beamPaint = Paint()
      ..shader = ui.Gradient.linear(
        Offset(cx, top),
        Offset(cx, 0),
        <Color>[
          const Color(0xFFFFE082).withValues(alpha: 0.55),
          const Color(0x00FFE082),
        ],
      );
    canvas.drawPath(beam, beamPaint);

    // 2. Soft drop shadow under the car.
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.30)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4);
    canvas.drawRRect(
      RRect.fromLTRBR(
        left + 2,
        top + 4,
        right + 2,
        bottom + 4,
        Radius.circular(radius),
      ),
      shadowPaint,
    );

    // 3. Car body — white rounded silhouette.
    final RRect body = RRect.fromLTRBR(
      left,
      top,
      right,
      bottom,
      Radius.circular(radius),
    );
    canvas.drawRRect(body, Paint()..color = Colors.white);
    canvas.drawRRect(
      body,
      Paint()
        ..color = const Color(0xFFBDBDBD)
        ..style = PaintingStyle.stroke
        ..strokeWidth = s * 0.012,
    );

    // 4. Cabin / glass — darker rounded panel in the middle third.
    final Paint glassPaint = Paint()..color = const Color(0xFF263238);
    // Windshield (toward the front).
    canvas.drawRRect(
      RRect.fromLTRBR(
        left + carWidth * 0.16,
        top + carLength * 0.18,
        right - carWidth * 0.16,
        top + carLength * 0.40,
        Radius.circular(carWidth * 0.12),
      ),
      glassPaint,
    );
    // Roof + rear window.
    canvas.drawRRect(
      RRect.fromLTRBR(
        left + carWidth * 0.18,
        top + carLength * 0.46,
        right - carWidth * 0.18,
        top + carLength * 0.78,
        Radius.circular(carWidth * 0.12),
      ),
      Paint()..color = const Color(0xFF37474F),
    );

    // 5. Side mirrors.
    final Paint mirrorPaint = Paint()..color = Colors.white;
    final double mirrorY = top + carLength * 0.22;
    canvas.drawRRect(
      RRect.fromLTRBR(
        left - carWidth * 0.12,
        mirrorY,
        left + carWidth * 0.04,
        mirrorY + carLength * 0.08,
        Radius.circular(s * 0.03),
      ),
      mirrorPaint,
    );
    canvas.drawRRect(
      RRect.fromLTRBR(
        right - carWidth * 0.04,
        mirrorY,
        right + carWidth * 0.12,
        mirrorY + carLength * 0.08,
        Radius.circular(s * 0.03),
      ),
      mirrorPaint,
    );

    final ui.Image image = await recorder.endRecording().toImage(
      s.toInt(),
      s.toInt(),
    );
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.bytes(byteData!.buffer.asUint8List());
  }
}
