import 'package:flutter/material.dart';

class SelectedItemChipStyle {
  const SelectedItemChipStyle({
    this.labelStyle,
    this.padding = const EdgeInsets.all(4),
    this.margin = const EdgeInsets.all(4),
    this.deleteIcon = const Icon(
      Icons.close,
      color: Colors.white,
      size: 18,
    ),
    this.elevation = 0,
    this.color,
    this.materialTapTargetSize = MaterialTapTargetSize.shrinkWrap,
  });

  final TextStyle? labelStyle;
  final EdgeInsets padding;
  final EdgeInsets margin;
  final Widget deleteIcon;
  final double elevation;
  final WidgetStateProperty<Color>? color;
  final MaterialTapTargetSize materialTapTargetSize;

  SelectedItemChipStyle copyWith({
    TextStyle? labelStyle,
    EdgeInsets? padding,
    EdgeInsets? margin,
    Widget? deleteIcon,
    double? elevation,
    WidgetStateProperty<Color>? color,
    MaterialTapTargetSize? materialTapTargetSize,
  }) {
    return SelectedItemChipStyle(
      labelStyle: labelStyle ?? this.labelStyle,
      padding: padding ?? this.padding,
      margin: margin ?? this.margin,
      deleteIcon: deleteIcon ?? this.deleteIcon,
      elevation: elevation ?? this.elevation,
      color: color ?? this.color,
      materialTapTargetSize:
          materialTapTargetSize ?? this.materialTapTargetSize,
    );
  }
}
