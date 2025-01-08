import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_searchfield_style.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    this.onSearch,
    this.searchDebouncer,
    this.searchfieldStyle = const NestedListSearchfieldStyle(),
    super.key,
  });

  final NestedListSearchfieldStyle searchfieldStyle;
  final SearchDebouncer? searchDebouncer;
  final Function(String)? onSearch;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  late final SearchDebouncer searchDebouncer;

  @override
  void initState() {
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
    searchDebouncer.reset();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.searchfieldStyle.margin,
      child: TextField(
        decoration: widget.searchfieldStyle.inputDecoration,
        textAlign: widget.searchfieldStyle.textAlign,
        style: widget.searchfieldStyle.textStyle,
        onChanged: (value) {
          searchDebouncer.run(() {
            widget.onSearch?.call(value);
          });
        },
      ),
    );
  }
}
