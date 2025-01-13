import 'dart:math';
import 'package:flutter/material.dart';

/// A custom painter that draws a border around an arrow-shaped path.
///
/// The [ArrowBorderPainter] class is used to paint a border around a widget
/// that has been clipped into an arrow shape.
class ArrowBorderPainter extends CustomPainter {
  /// Creates an [ArrowBorderPainter] instance.
  ///
  /// The [borderColor] and [borderWidth] parameters allow customization of
  /// the border's color and width.
  const ArrowBorderPainter({
    this.borderColor = Colors.white,
    this.borderWidth = 1,
  });

  /// The color of the border.
  final Color borderColor;

  /// The width of the border.
  final double borderWidth;

  @override
  void paint(Canvas canvas, Size size) {
    final width = max(size.width, size.height);
    final height = min(size.width, size.height);
    //
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;

    final borderPath = Path()
      ..moveTo(width - height / 4, 0)
      ..lineTo(width, height / 2)
      ..lineTo(width - height / 4, height)
      ..lineTo(0, height)
      ..lineTo(height / 4, height / 2)
      ..lineTo(0, 0)
      ..close();

    canvas.drawPath(borderPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
