import 'package:flutter/material.dart';

class NestedListSearchfieldStyle {
  const NestedListSearchfieldStyle({
    this.margin = const EdgeInsets.all(4),
    this.inputDecoration = const InputDecoration(
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
  final InputDecoration inputDecoration;

  NestedListSearchfieldStyle copyWith({
    EdgeInsets? margin,
    InputDecoration? inputDecoration,
  }) {
    return NestedListSearchfieldStyle(
      margin: margin ?? this.margin,
      inputDecoration: inputDecoration ?? this.inputDecoration,
    );
  }
}
