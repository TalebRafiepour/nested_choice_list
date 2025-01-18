import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/navigation_path/navigation_path.dart';

void main() {
  group('NavigationPath Tests', () {
    testWidgets('renders correctly with default parameters', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NavigationPath(
            pathes: ['Home', 'Settings', 'Profile'],
          ),
        ),
      );

      expect(find.byType(NavigationPath), findsOneWidget);
    });

    testWidgets('displays items correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NavigationPath(
            pathes: ['Home', 'Settings', 'Profile'],
          ),
        ),
      );

      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Settings'), findsOneWidget);
      expect(find.text('Profile'), findsOneWidget);
    });

    testWidgets('scroll animation works correctly', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: NavigationPath(
            pathes: ['Home', 'Settings', 'Profile', 'More', 'Items'],
          ),
        ),
      );

      final scrollController = ScrollController();
      await tester.pumpWidget(
        MaterialApp(
          home: SingleChildScrollView(
            controller: scrollController,
            scrollDirection: Axis.horizontal,
            child: const NavigationPath(
              pathes: ['Home', 'Settings', 'Profile', 'More', 'Items'],
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();
      expect(
        scrollController.offset,
        scrollController.position.maxScrollExtent,
      );
    });
  });
}
