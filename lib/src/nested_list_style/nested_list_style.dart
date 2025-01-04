import 'package:flutter/material.dart';

class NestedListStyle {
  const NestedListStyle({
    this.padding = const EdgeInsets.all(4),
    this.bgColor = Colors.transparent,
  });

  final EdgeInsets padding;
  final Color bgColor;

  NestedListStyle copyWith({
    EdgeInsets? padding,
  }) {
    return NestedListStyle(
      padding: padding ?? this.padding,
    );
  }
}
