import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_list_style/navigation_path_item_style.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_item_style.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_searchfield_style.dart';
import 'package:nested_choice_list/src/nested_list_style/selecte_item_chip_style.dart';

/// A class that defines the style for a nested list.
///
/// This class can be used to customize the appearance and behavior of
/// nested lists in your Flutter application.
class NestedListStyle {
  const NestedListStyle({
    this.searchfieldStyle = const NestedListSearchfieldStyle(),
    this.itemStyle = const NestedListItemStyle(),
    this.navigationPathItemStyle = const NavigationPathItemStyle(),
    this.selectAllItemStyle = const NestedListItemStyle(),
    this.selectedItemChipStyle = const SelectedItemChipStyle(),
    this.bgColor = Colors.white,
  });

  /// The style configuration for the search field in the nested list.
  ///
  /// This includes properties such as text style, background color,
  /// border style, and other visual aspects of the search field.
  final NestedListSearchfieldStyle searchfieldStyle;

  /// The style to be applied to each item in the nested list.
  ///
  /// This property holds an instance of [NestedListItemStyle] which defines
  /// the visual appearance and layout of the items within the nested list.
  final NestedListItemStyle itemStyle;

  /// A style configuration for the navigation path item in the nested list.
  ///
  /// This property defines the visual appearance and behavior of the navigation
  /// path item within the nested list. It allows customization of various
  /// aspects such as colors, fonts, and other stylistic elements.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// NavigationPathItemStyle(
  ///   color: Colors.blue,
  ///   fontSize: 16.0,
  ///   fontWeight: FontWeight.bold,
  /// );
  /// ```
  ///
  /// See also:
  ///
  ///  * [NavigationPathItemStyle], which provides more details on the available
  ///    customization options.
  final NavigationPathItemStyle navigationPathItemStyle;

  /// The style to be applied to the "Select All" item in the nested list.
  ///
  /// This property defines the visual appearance of the "Select All" item,
  /// including its text style, background color, and other UI elements.
  ///
  /// Example usage:
  ///
  /// ```dart
  /// NestedListItemStyle(
  ///   textStyle: TextStyle(color: Colors.blue),
  ///   backgroundColor: Colors.grey[200],
  /// )
  /// ```
  ///
  /// This allows customization of the "Select All" item to match the overall
  /// theme and design of the application.
  final NestedListItemStyle selectAllItemStyle;

  /// The style to be applied to the selected item chip.
  ///
  /// This includes properties such as color, shape, and text style
  /// that define the appearance of the chip when an item is selected.
  final SelectedItemChipStyle selectedItemChipStyle;

  /// The background color for the nested list style.
  final Color bgColor;

  /// Creates a copy of this `NestedListStyle` but with the given fields
  /// replaced with the new values.
  ///
  /// The fields that can be replaced are:
  /// - [searchfieldStyle]: The style for the search field.
  /// - [itemStyle]: The style for the items in the list.
  /// - [navigationPathItemStyle]: The style for the navigation path items.
  /// - [selectAllItemStyle]: The style for the "select all" item.
  /// - [selectedItemChipStyle]: The style for the selected item chips.
  /// - [bgColor]: The background color.
  ///
  /// If a field is not provided, the current value of that field will be used.
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
