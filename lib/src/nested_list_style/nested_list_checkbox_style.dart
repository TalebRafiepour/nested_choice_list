import 'package:flutter/material.dart';

/// A class that defines customizable styling for a nested list checkbox.
///
/// This style object allows you to configure numerous visual and interaction
/// properties of a nested list checkbox, such as colors, shapes, focus
/// behavior, and more.
class NestedListCheckboxStyle {
  /// Creates a [NestedListCheckboxStyle] instance with optional styling
  /// configurations.
  ///
  /// Each parameter corresponds to a particular visual or interactive aspect
  /// of the checkbox.
  const NestedListCheckboxStyle({
    this.mouseCursor,
    this.activeColor,
    this.fillColor,
    this.checkColor,
    this.focusColor,
    this.hoverColor,
    this.overlayColor,
    this.splashRadius,
    this.materialTapTargetSize = MaterialTapTargetSize.shrinkWrap,
    this.visualDensity,
    this.focusNode,
    this.autofocus = false,
    this.shape,
    this.side,
    this.isError = false,
    this.semanticLabel,
  });

  /// The cursor to display when the mouse hovers over the checkbox.
  final MouseCursor? mouseCursor;

  /// The color of the checkbox when it is in active state.
  final Color? activeColor;

  /// The fill color of the checkbox, which can vary depending on its state.
  final WidgetStateProperty<Color?>? fillColor;

  /// The color applied to the check icon inside the checkbox.
  final Color? checkColor;

  /// The color used when the checkbox receives focus.
  final Color? focusColor;

  /// The color when the checkbox is hovered over.
  final Color? hoverColor;

  /// The overlay color used for interactive effects on the checkbox.
  final WidgetStateProperty<Color?>? overlayColor;

  /// The radius of the splash effect triggered when the checkbox is tapped.
  final double? splashRadius;

  /// The material tap target size, which affects the size of the interactive
  /// area.
  final MaterialTapTargetSize? materialTapTargetSize;

  /// The visual density of the checkbox, controlling its overall size and
  /// spacing.
  final VisualDensity? visualDensity;

  /// The focus node used for managing focus on the checkbox.
  final FocusNode? focusNode;

  /// Whether the checkbox should automatically obtain focus when it is built.
  final bool autofocus;

  /// The shape applied to the checkbox's border.
  final OutlinedBorder? shape;

  /// The border style for the checkbox.
  final BorderSide? side;

  /// Indicates whether the checkbox is in an error state.
  final bool isError;

  /// The semantic label for the checkbox, useful for accessibility.
  final String? semanticLabel;

  /// Returns a copy of this [NestedListCheckboxStyle] with the given fields
  /// replaced by new values.
  ///
  /// Fields that are null are preserved with their original values from this
  /// instance.
  NestedListCheckboxStyle copyWith({
    MouseCursor? mouseCursor,
    Color? activeColor,
    WidgetStateProperty<Color?>? fillColor,
    Color? checkColor,
    Color? focusColor,
    Color? hoverColor,
    WidgetStateProperty<Color?>? overlayColor,
    double? splashRadius,
    MaterialTapTargetSize? materialTapTargetSize,
    VisualDensity? visualDensity,
    FocusNode? focusNode,
    bool? autofocus,
    OutlinedBorder? shape,
    BorderSide? side,
    bool? isError,
    String? semanticLabel,
  }) {
    return NestedListCheckboxStyle(
      mouseCursor: mouseCursor ?? this.mouseCursor,
      activeColor: activeColor ?? this.activeColor,
      fillColor: fillColor ?? this.fillColor,
      checkColor: checkColor ?? this.checkColor,
      focusColor: focusColor ?? this.focusColor,
      hoverColor: hoverColor ?? this.hoverColor,
      overlayColor: overlayColor ?? this.overlayColor,
      splashRadius: splashRadius ?? this.splashRadius,
      materialTapTargetSize:
          materialTapTargetSize ?? this.materialTapTargetSize,
      visualDensity: visualDensity ?? this.visualDensity,
      focusNode: focusNode ?? this.focusNode,
      autofocus: autofocus ?? this.autofocus,
      shape: shape ?? this.shape,
      side: side ?? this.side,
      isError: isError ?? this.isError,
      semanticLabel: semanticLabel ?? this.semanticLabel,
    );
  }
}
