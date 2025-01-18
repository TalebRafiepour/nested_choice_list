import 'package:flutter_test/flutter_test.dart';
import 'package:nested_choice_list/src/search_field/search_debouncer.dart';

void main() {
  group('SearchDebouncer Tests', () {
    test('executes action after specified duration', () async {
      bool actionExecuted = false;
      final _ = SearchDebouncer(
        duration: const Duration(milliseconds: 100),
      )..run(() {
          actionExecuted = true;
        });

      // Wait for the duration to pass
      await Future.delayed(const Duration(milliseconds: 150));

      expect(actionExecuted, isTrue);
    });

    test('cancels previous timer if run is called again', () async {
      bool firstActionExecuted = false;
      bool secondActionExecuted = false;
      final debouncer =
          SearchDebouncer(duration: const Duration(milliseconds: 100))
            ..run(() {
              firstActionExecuted = true;
            });

      // Call run again before the first duration ends
      await Future.delayed(const Duration(milliseconds: 50));

      debouncer.run(() {
        secondActionExecuted = true;
      });

      // Wait for the duration to pass
      await Future.delayed(const Duration(milliseconds: 150));

      expect(firstActionExecuted, isFalse);
      expect(secondActionExecuted, isTrue);
    });

    test('reset cancels the timer and sets it to null', () async {
      bool actionExecuted = false;
      final debouncer =
          SearchDebouncer(duration: const Duration(milliseconds: 100))
            ..run(() {
              actionExecuted = true;
            });

      // Call reset before the duration ends
      await Future.delayed(const Duration(milliseconds: 50));
      debouncer.reset();

      // Wait for the original duration to pass
      await Future.delayed(const Duration(milliseconds: 100));

      expect(actionExecuted, isFalse);
      expect(debouncer.timer, isNull);
    });
  });
}
