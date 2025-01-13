import 'package:flutter/material.dart';

/// A class that defines the style for a navigation path item.
class NavigationPathItemStyle {
  /// Creates a [NavigationPathItemStyle] with the given properties.
  ///
  /// The [color] defaults to a light grey color.
  /// The [padding] and [margin] default to [EdgeInsets.zero].
  /// The [borderColor] defaults to [Colors.white].
  /// The [borderWidth] defaults to 1.
  const NavigationPathItemStyle({
    this.color = const Color.fromARGB(255, 234, 225, 225),
    this.labelStyle,
    this.padding = EdgeInsets.zero,
    this.margin = EdgeInsets.zero,
    this.borderColor = Colors.white,
    this.borderWidth = 1,
  });

  /// The style for the label text.
  final TextStyle? labelStyle;

  /// The padding around the item.
  final EdgeInsets padding;

  /// The margin around the item.
  final EdgeInsets margin;

  /// The background color of the item.
  final Color color;

  /// The color of the border around the item.
  final Color borderColor;

  /// The width of the border around the item.
  final double borderWidth;

  /// Creates a copy of this [NavigationPathItemStyle] but with the given fields
  /// replaced with the new values.
  ///
  /// If a field is not provided, the value from the current instance is used.
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
