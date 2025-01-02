import 'dart:math';

import 'package:flutter/material.dart';

class ArrowClipper extends CustomClipper<Path> {
  const ArrowClipper();

  @override
  Path getClip(Size size) {
    final width = max(size.width, size.height);
    final height = min(size.width, size.height);

    Path path = Path();
    path.moveTo(width - height / 4, 0);
    path.lineTo(width, height / 2);
    path.lineTo(width - height / 4, height);
    path.lineTo(0, height);
    path.lineTo(height / 4, height / 2);
    path.lineTo(0, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper oldClipper) {
    return false;
  }
}
