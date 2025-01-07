import 'package:flutter/material.dart';

class NestedListStyle {
  const NestedListStyle({
    this.padding = const EdgeInsets.all(4),
    this.bgColor = Colors.white,
  });

  final EdgeInsets padding;
  final Color bgColor;

  NestedListStyle copyWith({
    EdgeInsets? padding,
    Color? bgColor,
  }) {
    return NestedListStyle(
      padding: padding ?? this.padding,
      bgColor: bgColor ?? this.bgColor,
    );
  }
}
