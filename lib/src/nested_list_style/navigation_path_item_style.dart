import 'package:flutter/material.dart';

class NavigationPathItemStyle {
  const NavigationPathItemStyle({
    this.color = const Color.fromARGB(255, 234, 225, 225),
    this.labelStyle,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.borderColor = Colors.white,
    this.borderWidth = 1,
  });

  final TextStyle? labelStyle;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Color color;
  final Color borderColor;
  final double borderWidth;

  NavigationPathItemStyle copyWith({
    TextStyle? labelStyle,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Color? color,
    Color? borderColor,
    double? borderWidth,
  }) {
    return NavigationPathItemStyle(
      labelStyle: labelStyle ?? this.labelStyle,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      color: color ?? this.color,
      borderColor: borderColor ?? this.borderColor,
      borderWidth: borderWidth ?? this.borderWidth,
    );
  }
}
