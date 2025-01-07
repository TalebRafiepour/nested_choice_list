import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_searchfield_style.dart';

class NestedListStyle {
  const NestedListStyle({
    this.searchfieldStyle = const NestedListSearchfieldStyle(),
    this.itemStyle = const NestedListItemStyle(),
    this.selectAllItemStyle = const NestedListItemStyle(),
    this.bgColor = Colors.white,
  });

  final NestedListSearchfieldStyle searchfieldStyle;
  final NestedListItemStyle itemStyle;
  final NestedListItemStyle selectAllItemStyle;
  final Color bgColor;

  NestedListStyle copyWith({
    NestedListSearchfieldStyle? searchfieldStyle,
    NestedListItemStyle? itemStyle,
    NestedListItemStyle? selectAllItemStyle,
    Color? bgColor,
  }) {
    return NestedListStyle(
      searchfieldStyle: searchfieldStyle ?? this.searchfieldStyle,
      itemStyle: itemStyle ?? this.itemStyle,
      selectAllItemStyle: selectAllItemStyle ?? this.selectAllItemStyle,
      bgColor: bgColor ?? this.bgColor,
    );
  }
}
