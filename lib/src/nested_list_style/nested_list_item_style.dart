import 'package:flutter/material.dart';

class NestedListItemStyle {
  const NestedListItemStyle({
    this.bgColor = Colors.white,
    this.shape = const RoundedRectangleBorder(
      side: BorderSide(
        color: Color.fromARGB(255, 189, 189, 189),
      ),
      borderRadius: BorderRadius.all(
        Radius.circular(8),
      ),
    ),
    this.trailingIcon = const Icon(
      Icons.arrow_right,
      size: 24,
    ),
    this.labelStyle,
    this.listPadding = EdgeInsets.zero,
    this.margin = const EdgeInsets.all(4),
  });

  final ShapeBorder? shape;
  final Icon? trailingIcon;
  final TextStyle? labelStyle;
  final EdgeInsets listPadding;
  final EdgeInsets margin;
  final Color bgColor;

  NestedListItemStyle copyWith({
    ShapeBorder? shape,
    Icon? trailingIcon,
    TextStyle? labelStyle,
    EdgeInsets? listPadding,
    EdgeInsets? margin,
    EdgeInsets? searchFieldMargin,
    InputDecoration? searchInputDecoration,
    Color? bgColor,
  }) {
    return NestedListItemStyle(
      shape: shape ?? this.shape,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      labelStyle: labelStyle ?? this.labelStyle,
      listPadding: listPadding ?? this.listPadding,
      margin: margin ?? this.margin,
      bgColor: bgColor ?? this.bgColor,
    );
  }
}
