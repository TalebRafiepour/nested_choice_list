import 'dart:math';

import 'package:flutter/material.dart';

class ArrowBorderPainter extends CustomPainter {
  const ArrowBorderPainter({
    this.borderColor = Colors.white,
    this.borderWidth = 1,
  });

  final Color borderColor;
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
