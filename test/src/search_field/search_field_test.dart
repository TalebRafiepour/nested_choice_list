import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/nested_list_style/nested_list_searchfield_style.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';
import 'package:nested_choice_list/src/search_field/search_field.dart';

void main() {
  group('SearchField Tests', () {
    testWidgets('renders correctly with default parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SearchField(),
          ),
        ),
      );

      expect(find.byType(TextField), findsOneWidget);
    });

    testWidgets('onSearch callback is triggered with debounced input',
        (tester) async {
      String? searchQuery;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              onSearch: (query) {
                searchQuery = query;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'test');
      await tester.pump(const Duration(milliseconds: 200));

      expect(searchQuery, 'test');
    });

    testWidgets('searchDebouncer is used correctly', (tester) async {
      final debouncer =
          SearchDebouncer(duration: const Duration(milliseconds: 500));
      String? searchQuery;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SearchField(
              searchDebouncer: debouncer,
              onSearch: (query) {
                searchQuery = query;
              },
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField), 'debounce test');
      await tester.pump(const Duration(milliseconds: 200));
      expect(searchQuery, isNull);

      await tester.pump(const Duration(milliseconds: 300));
      expect(searchQuery, 'debounce test');
    });

    testWidgets('searchfieldStyle is applied correctly', (tester) async {
      const style = NestedListSearchfieldStyle(
        margin: EdgeInsets.all(10),
        inputDecoration: InputDecoration(hintText: 'Search...'),
        textAlign: TextAlign.center,
        textStyle: TextStyle(color: Colors.red),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SearchField(
              searchfieldStyle: style,
            ),
          ),
        ),
      );

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.decoration?.hintText, 'Search...');
      expect(textField.textAlign, TextAlign.center);
      expect(textField.style?.color, Colors.red);
    });
  });
}
