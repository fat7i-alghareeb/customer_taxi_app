import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:customertaxi/utils/gen/assets.gen.dart';

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

  /// Builds a "dot-in-ring" marker: a solid centre dot, a transparent gap, then a
  /// solid colored border ring — used for the pickup/destination points instead of
  /// the lettered A/B circles. [color] tints both the dot and the ring so pickup and
  /// destination stay distinguishable by color.
  static Future<BitmapDescriptor> createDotRingMarker({
    required Color color,
    double size = 45,
  }) async {
    final ui.PictureRecorder pictureRecorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(pictureRecorder);
    final double radius = size / 2;
    final Offset center = Offset(radius, radius);

    // Geometry: outer ring sits a little in from the edge to leave room for the
    // shadow; the dot is centred with a transparent gap between it and the ring.
    final double ringRadius = radius - (size * 0.14);
    final double ringStroke = size * 0.11;
    final double dotRadius = size * 0.16;

    // 1. Soft drop shadow under the ring.
    final Paint shadowPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.22)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5);
    canvas.drawCircle(center.translate(0, 3), ringRadius, shadowPaint);

    // 2. Outer border ring (stroke only — the interior stays transparent).
    final Paint ringPaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = ringStroke;
    canvas.drawCircle(center, ringRadius, ringPaint);

    // 3. Solid centre dot.
    final Paint dotPaint = Paint()..color = color;
    canvas.drawCircle(center, dotRadius, dotPaint);

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

  /// Builds the driver's vehicle marker from the [carForRealTime] asset so the
  /// map uses the same car as the live-tracking sheet. The asset is a right-facing
  /// side-view car, decoded and scaled to [width] logical-ish pixels. Pass
  /// [mirror] to get the left-facing variant, used when the driver heads west so
  /// the upright car still faces its direction of travel.
  static Future<BitmapDescriptor> createVehicleMarker({
    double width = 80,
    bool mirror = false,
  }) async {
    final ByteData data = await rootBundle.load(
      Assets.images.carForRealTime.path,
    );
    final int size = width.toInt();
    final ui.Codec codec = await ui.instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: size,
      targetHeight: size,
    );
    final ui.FrameInfo frame = await codec.getNextFrame();
    final ui.Image image = mirror
        ? await _flipHorizontally(frame.image, size)
        : frame.image;
    final ByteData? byteData = await image.toByteData(
      format: ui.ImageByteFormat.png,
    );
    return BitmapDescriptor.bytes(byteData!.buffer.asUint8List());
  }

  /// Returns a horizontally-mirrored copy of [src] (a [size]×[size] image).
  static Future<ui.Image> _flipHorizontally(ui.Image src, int size) async {
    final ui.PictureRecorder recorder = ui.PictureRecorder();
    final Canvas canvas = Canvas(recorder);
    canvas.translate(size.toDouble(), 0);
    canvas.scale(-1, 1);
    canvas.drawImage(src, Offset.zero, Paint());
    return recorder.endRecording().toImage(size, size);
  }
}
