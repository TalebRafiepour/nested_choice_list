import 'package:flutter/material.dart';

/// A class that defines the style for a `SelectedItemChip`.
///
/// The [SelectedItemChipStyle] class allows customization of various aspects
/// of the chip, including padding, margin, label style, delete icon, elevation,
/// color, and material tap target size.
class SelectedItemChipStyle {
  /// Creates a [SelectedItemChipStyle] with the given parameters.
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

  /// The style to be applied to the label text inside the chip.
  final TextStyle? labelStyle;

  /// The padding inside the chip.
  final EdgeInsets padding;

  /// The margin outside the chip.
  final EdgeInsets margin;

  /// The icon to be used for the delete action.
  final Widget deleteIcon;

  /// The elevation of the chip.
  final double elevation;

  /// The color of the chip.
  final WidgetStateProperty<Color>? color;

  /// The material tap target size of the chip.
  final MaterialTapTargetSize materialTapTargetSize;

  /// Creates a copy of this [SelectedItemChipStyle] but with the given fields
  /// replaced with the new values.
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
