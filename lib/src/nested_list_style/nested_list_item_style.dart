import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_checkbox_style.dart';

/// A class that defines the style for an item in a nested list.
///
/// This class can be used to customize the appearance of individual items
/// within a nested list, such as their background color, text style, padding,
/// and other visual properties.
class NestedListItemStyle {
  const NestedListItemStyle({
    this.checkboxStyle = const NestedListCheckboxStyle(),
    this.visualDensity = const VisualDensity(
      vertical: -1,
    ),
    this.bgColor = Colors.white,
    this.dense = true,
    this.shape,
    this.trailingIcon = const Icon(
      Icons.arrow_right,
      size: 24,
    ),
    this.labelStyle,
    this.listPadding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(4),
  });

  /// The style of the checkbox in the list item.
  final NestedListCheckboxStyle checkboxStyle;

  /// Defines how compact the visual representation of the nested list item is.
  ///
  /// This property controls the density of the visual elements, such as padding
  /// and spacing, within the nested list item. It can be used to make the list
  /// items appear more or less compact.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// NestedListItemStyle(
  ///   visualDensity: VisualDensity.compact,
  /// )
  /// ```
  final VisualDensity visualDensity;

  /// The shape of the border to be drawn around the list item.
  ///
  /// This property defines the shape and appearance of the border
  /// around the list item. It can be any shape that implements
  /// the [ShapeBorder] interface, such as [RoundedRectangleBorder],
  /// [CircleBorder], etc. If null, no border will be drawn.
  final ShapeBorder? shape;

  /// An optional icon to display at the end of the list item.
  ///
  /// This icon is typically used to indicate an action or provide additional
  /// information about the list item. If no icon is provided, the trailing
  /// space will be empty.
  final Icon? trailingIcon;

  /// The text style to use for the label of the nested list item.
  ///
  /// This property allows you to customize the appearance of the label text,
  /// such as its color, font size, font weight, and other text styling options.
  ///
  /// If null, the default text style will be used.
  final TextStyle? labelStyle;

  /// The padding to apply to the list.
  ///
  /// This padding is applied to the entire list, providing space around the
  /// list items. It can be used to control the spacing between the list
  /// and its surrounding elements.
  final EdgeInsets listPadding;

  /// The margin around the nested list item.
  ///
  /// This property defines the amount of space to be added around the
  /// nested list item. It is represented as an [EdgeInsets] object,
  /// which allows you to specify the margin for each side of the item
  /// (left, top, right, and bottom).
  final EdgeInsets margin;

  /// The background color of the nested list item.
  final Color bgColor;

  /// Whether the list item is part of a dense list.
  ///
  /// Dense lists have smaller heights and are typically used when
  /// there are many items to display, allowing more items to fit
  /// on the screen at once.
  final bool dense;

  /// Creates a copy of this [NestedListItemStyle] but with the given fields
  /// replaced with the new values.
  ///
  /// The [copyWith] method allows you to create a new instance of
  /// [NestedListItemStyle] with some properties updated while keeping the
  /// other properties unchanged.
  ///
  /// The parameters are:
  ///
  /// * [checkboxStyle]: The style of the checkbox in the list item.
  /// * [shape]: The shape border of the list item.
  /// * [trailingIcon]:The icon displayed at the trailing edge of the list item.
  /// * [labelStyle]: The text style of the label.
  /// * [listPadding]: The padding of the list.
  /// * [margin]: The margin around the list item.
  /// * [searchFieldMargin]: The margin around the search field.
  /// * [searchInputDecoration]: The input decoration for the search field.
  /// * [bgColor]: The background color of the list item.
  /// * [dense]: Whether the list item is dense.
  ///
  /// If any of the parameters are not provided, the corresponding property
  /// from the current instance will be used.
  NestedListItemStyle copyWith({
    NestedListCheckboxStyle? checkboxStyle,
    ShapeBorder? shape,
    Icon? trailingIcon,
    TextStyle? labelStyle,
    EdgeInsets? listPadding,
    EdgeInsets? margin,
    EdgeInsets? searchFieldMargin,
    InputDecoration? searchInputDecoration,
    Color? bgColor,
    bool? dense,
  }) {
    return NestedListItemStyle(
      checkboxStyle: checkboxStyle ?? this.checkboxStyle,
      shape: shape ?? this.shape,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      labelStyle: labelStyle ?? this.labelStyle,
      listPadding: listPadding ?? this.listPadding,
      margin: margin ?? this.margin,
      bgColor: bgColor ?? this.bgColor,
      dense: dense ?? this.dense,
    );
  }
}
