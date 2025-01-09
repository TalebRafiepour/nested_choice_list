import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_list_style/navigation_path_item_style.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_searchfield_style.dart';
import 'package:nested_choice_list/src/nested_list_style/selecte_item_chip_style.dart';

class NestedListStyle {
  const NestedListStyle({
    this.searchfieldStyle = const NestedListSearchfieldStyle(),
    this.itemStyle = const NestedListItemStyle(),
    this.navigationPathItemStyle = const NavigationPathItemStyle(),
    this.selectAllItemStyle = const NestedListItemStyle(),
    this.selectedItemChipStyle = const SelectedItemChipStyle(),
    this.bgColor = Colors.white,
  });

  final NestedListSearchfieldStyle searchfieldStyle;
  final NestedListItemStyle itemStyle;
  final NavigationPathItemStyle navigationPathItemStyle;
  final NestedListItemStyle selectAllItemStyle;
  final SelectedItemChipStyle selectedItemChipStyle;
  final Color bgColor;

  NestedListStyle copyWith({
    NestedListSearchfieldStyle? searchfieldStyle,
    NestedListItemStyle? itemStyle,
    NavigationPathItemStyle? navigationPathItemStyle,
    NestedListItemStyle? selectAllItemStyle,
    SelectedItemChipStyle? selectedItemChipStyle,
    Color? bgColor,
  }) {
    return NestedListStyle(
      searchfieldStyle: searchfieldStyle ?? this.searchfieldStyle,
      itemStyle: itemStyle ?? this.itemStyle,
      selectedItemChipStyle:
          selectedItemChipStyle ?? this.selectedItemChipStyle,
      navigationPathItemStyle:
          navigationPathItemStyle ?? this.navigationPathItemStyle,
      selectAllItemStyle: selectAllItemStyle ?? this.selectAllItemStyle,
      bgColor: bgColor ?? this.bgColor,
    );
  }
}
