import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/navigation_path/arrow_box_container.dart';
import 'package:nested_choice_list/src/navigation_path/navigation_path_item.dart';
import 'package:nested_choice_list/src/nested_list_style/navigation_path_item_style.dart';

void main() {
  group('NavigationPathItem Tests', () {
    testWidgets('renders correctly with default parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NavigationPathItem(
              lable: 'Test Label',
            ),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
    });

    testWidgets('label is displayed correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NavigationPathItem(
              lable: 'Test Label',
            ),
          ),
        ),
      );

      expect(find.text('Test Label'), findsOneWidget);
    });

    testWidgets('onTap callback is triggered when tapped', (tester) async {
      bool wasTapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: NavigationPathItem(
              lable: 'Test Label',
              onTap: () {
                wasTapped = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('Test Label'));
      await tester.pump();

      expect(wasTapped, isTrue);
    });

    testWidgets('custom style is applied correctly', (tester) async {
      const customStyle = NavigationPathItemStyle(
        color: Colors.red,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.all(4),
        borderColor: Colors.blue,
        borderWidth: 2,
        labelStyle: TextStyle(fontSize: 20, color: Colors.green),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: NavigationPathItem(
              lable: 'Styled Label',
              navigationPathItemStyle: customStyle,
            ),
          ),
        ),
      );

      final arrowBoxContainer = tester.widget<ArrowBoxContainer>(
        find.byType(ArrowBoxContainer),
      );

      expect(arrowBoxContainer.color, customStyle.color);
      expect(arrowBoxContainer.padding, customStyle.padding);
      expect(arrowBoxContainer.borderColor, customStyle.borderColor);
      expect(arrowBoxContainer.borderWidth, customStyle.borderWidth);

      final text = tester.widget<Text>(find.text('Styled Label'));
      expect(text.style?.fontSize, customStyle.labelStyle?.fontSize);
      expect(text.style?.color, customStyle.labelStyle?.color);
    });
  });
}
