import 'dart:math';
import 'package:flutter/material.dart';

/// A custom clipper that creates an arrow-shaped path.
///
/// The [ArrowClipper] class is used to clip a widget into an arrow shape.
class ArrowClipper extends CustomClipper<Path> {
  /// Creates an [ArrowClipper] instance.
  const ArrowClipper();

  @override
  Path getClip(Size size) {
    final width = max(size.width, size.height);
    final height = min(size.width, size.height);

    return Path()
      ..moveTo(width - height / 4, 0)
      ..lineTo(width, height / 2)
      ..lineTo(width - height / 4, height)
      ..lineTo(0, height)
      ..lineTo(height / 4, height / 2)
      ..lineTo(0, 0)
      ..close();
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
