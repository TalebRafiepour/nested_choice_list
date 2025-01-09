import 'dart:math';

import 'package:flutter/material.dart';

class ArrowClipper extends CustomClipper<Path> {
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
