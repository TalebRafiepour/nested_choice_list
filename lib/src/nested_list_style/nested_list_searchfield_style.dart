import 'package:flutter/material.dart';

/// A class that defines the style for the search field in the nested list.
///
/// This class allows customization of the search field's appearance,
/// including text style, text alignment, margin, and input decoration.
class NestedListSearchfieldStyle {
  /// Creates a new instance of [NestedListSearchfieldStyle].
  ///
  /// The [textStyle], [textAlign], [margin], and [inputDecoration] parameters
  /// can be customized to define the appearance of the search field.
  const NestedListSearchfieldStyle({
    this.textStyle = const TextStyle(
      fontSize: 14,
      fontWeight: FontWeight.w400,
    ),
    this.textAlign = TextAlign.start,
    this.margin = const EdgeInsets.all(4),
    this.inputDecoration = const InputDecoration(
      isDense: true,
      border: OutlineInputBorder(),
      prefixIcon: Icon(
        Icons.search,
        size: 24,
      ),
      hintText: 'Search',
      hintStyle: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
      ),
    ),
  });

  /// The margin around the search field.
  final EdgeInsets margin;

  /// The text alignment within the search field.
  final TextAlign textAlign;

  /// The input decoration for the search field.
  final InputDecoration inputDecoration;

  /// The text style for the search field.
  final TextStyle textStyle;

  /// Creates a copy of this [NestedListSearchfieldStyle] with the given fields
  /// replaced with the new values.
  ///
  /// The [margin], [inputDecoration], and [textAlign] parameters can be
  /// provided to override the existing values.
  NestedListSearchfieldStyle copyWith({
    EdgeInsets? margin,
    InputDecoration? inputDecoration,
    TextAlign? textAlign,
  }) {
    return NestedListSearchfieldStyle(
      margin: margin ?? this.margin,
      inputDecoration: inputDecoration ?? this.inputDecoration,
      textAlign: textAlign ?? this.textAlign,
    );
  }
}
