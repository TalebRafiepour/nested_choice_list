import 'package:flutter/material.dart';

class NavigationPathItemStyle {
  const NavigationPathItemStyle({
    this.color = const Color.fromARGB(255, 234, 225, 225),
    this.labelStyle,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
  });

  final TextStyle? labelStyle;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;

  NavigationPathItemStyle copyWith({
    TextStyle? labelStyle,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
  }) {
    return NavigationPathItemStyle(
      labelStyle: labelStyle ?? this.labelStyle,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      color: color ?? this.color,
    );
  }
}
