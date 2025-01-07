import 'package:flutter/material.dart';

class NestedListSearchfieldStyle {
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

  //
  final EdgeInsets margin;
  final TextAlign textAlign;
  final InputDecoration inputDecoration;
  final TextStyle textStyle;

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
