import 'package:flutter/material.dart';

class NestedListViewStyle {
  const NestedListViewStyle({
    this.searchFieldMargin = const EdgeInsets.all(4),
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
    this.itemMargin = const EdgeInsets.all(4),
    this.searchInputDecoration = const InputDecoration(
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

  final ShapeBorder? itemShape;
  final Icon? trailingIcon;
  final TextStyle? labelStyle;
  final EdgeInsets? listPadding;
  final EdgeInsets itemMargin;
  //
  final EdgeInsets searchFieldMargin;
  final InputDecoration searchInputDecoration;

  NestedListViewStyle copyWith({
    ShapeBorder? itemShape,
    Icon? trailingIcon,
    TextStyle? labelStyle,
    EdgeInsets? listPadding,
    EdgeInsets? itemMargin,
    EdgeInsets? searchFieldMargin,
    InputDecoration? searchInputDecoration,
  }) {
    return NestedListViewStyle(
      itemShape: itemShape ?? this.itemShape,
      trailingIcon: trailingIcon ?? this.trailingIcon,
      labelStyle: labelStyle ?? this.labelStyle,
      listPadding: listPadding ?? this.listPadding,
      itemMargin: itemMargin ?? this.itemMargin,
      searchFieldMargin: searchFieldMargin ?? this.searchFieldMargin,
      searchInputDecoration:
          searchInputDecoration ?? this.searchInputDecoration,
    );
  }
}
