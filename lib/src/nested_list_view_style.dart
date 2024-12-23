import 'package:flutter/material.dart';

class NestedListViewStyle {
  const NestedListViewStyle({
    this.itemShape = const RoundedRectangleBorder(
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
    this.listPadding,
    this.itemMargin,
  });

  final ShapeBorder? itemShape;
  final Icon? trailingIcon;
  final TextStyle? labelStyle;
  final EdgeInsets? listPadding;
  final EdgeInsets? itemMargin;
}
