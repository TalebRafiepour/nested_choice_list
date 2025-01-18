import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/nested_list_style/selecte_item_chip_style.dart';
import 'package:nested_choice_list/src/selected_item_chip_list/selected_item_chip.dart';

void main() {
  group('SelectedItemChip Tests', () {
    testWidgets('displays the correct title', (tester) async {
      const title = 'Test Title';
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SelectedItemChip(
              title: title,
            ),
          ),
        ),
      );

      expect(find.text(title), findsOneWidget);
    });

    testWidgets('applies the correct style', (tester) async {
      const title = 'Styled Title';
      const style = SelectedItemChipStyle(
        padding: EdgeInsets.all(8),
        color: WidgetStatePropertyAll(Colors.red),
        elevation: 4,
        labelStyle: TextStyle(color: Colors.yellow),
      );

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: SelectedItemChip(
              title: title,
              selecteItemChipStyle: style,
            ),
          ),
        ),
      );

      final chip = tester.widget<Chip>(find.byType(Chip));
      expect(chip.padding, style.padding);
      expect(chip.color, style.color);
      expect(chip.elevation, style.elevation);
      expect(chip.labelStyle?.color, style.labelStyle?.color);
    });

    testWidgets('triggers onDeleted callback when deleted', (tester) async {
      bool deleted = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SelectedItemChip(
              title: 'Deletable Chip',
              onDeleted: () {
                deleted = true;
              },
            ),
          ),
        ),
      );
      await tester.tap(find.byType(Chip).first);
      await tester.pump();
      // Verify that the onDeleted callback was not triggered when tap on Chip
      expect(deleted, isFalse);

      await tester.tap(find.byIcon(Icons.close).first);
      await tester.pump();
      // Verify that the onDeleted callback was triggered when tap on cross Icon
      expect(deleted, isTrue);
    });
  });
}
