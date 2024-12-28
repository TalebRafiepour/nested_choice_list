import 'package:flutter/material.dart';
import 'package:nested_choice_list/src/search_debouncer.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    required this.inputDecoration,
    this.onSearch,
    this.searchDebouncer,
    this.margin = const EdgeInsets.symmetric(
      vertical: 0,
      horizontal: 6,
    ),
    super.key,
  });

  final InputDecoration inputDecoration;
  final EdgeInsets margin;
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
    return SafeArea(
      child: Padding(
        padding: widget.margin.copyWith(
          bottom:
              MediaQuery.of(context).viewInsets.bottom + widget.margin.bottom,
        ),
        child: TextField(
          decoration: widget.inputDecoration,
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
