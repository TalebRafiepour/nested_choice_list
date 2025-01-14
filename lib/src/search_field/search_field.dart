import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_searchfield_style.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';

/// A [StatefulWidget] that represents a search field with debouncing
/// capability.
///
/// This widget allows users to input search queries, and it debounces the input
/// to reduce the frequency of search callbacks.
class SearchField extends StatefulWidget {
  /// Creates a new instance of [SearchField].
  ///
  /// The [onSearch], [searchDebouncer], and [searchfieldStyle] parameters
  /// can be customized to define the behavior and appearance of the
  /// search field.
  const SearchField({
    this.onSearch,
    this.searchDebouncer,
    this.searchfieldStyle = const NestedListSearchfieldStyle(),
    super.key,
  });

  /// The style for the search field.
  final NestedListSearchfieldStyle searchfieldStyle;

  /// The debouncer for the search field.
  final SearchDebouncer? searchDebouncer;

  /// The callback function to handle search input changes.
  final Function(String)? onSearch;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  /// The debouncer instance used to debounce search input changes.
  late final SearchDebouncer searchDebouncer;

  @override
  void initState() {
    /// Initializes the search debouncer with the provided debouncer or
    /// creates a new one with a default duration of 200 milliseconds.
    searchDebouncer = widget.searchDebouncer ??
        SearchDebouncer(
          duration: const Duration(
            milliseconds: 200,
          ),
        );
    super.initState();
  }

  @override
  void dispose() {
    /// Resets the search debouncer when the widget is disposed.
    searchDebouncer.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      /// Applies the margin specified in the search field style.
      padding: widget.searchfieldStyle.margin,
      child: Material(
        child: TextField(
          /// Applies the input decoration specified in the search field style.
          decoration: widget.searchfieldStyle.inputDecoration,

          /// Applies the text alignment specified in the search field style.
          textAlign: widget.searchfieldStyle.textAlign,

          /// Applies the text style specified in the search field style.
          style: widget.searchfieldStyle.textStyle,

          /// Handles changes to the search input and debounces
          /// the input changes.
          onChanged: (value) {
            searchDebouncer.run(() {
              widget.onSearch?.call(value);
            });
          },
        ),
      ),
    );
  }
}
