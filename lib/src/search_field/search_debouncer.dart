import 'dart:async';
import 'dart:ui';

/// A utility class that helps to debounce search input.
///
/// This class can be used to delay the execution of a search operation
/// until the user has stopped typing for a specified duration. This is
/// useful to prevent sending too many search requests in a short period
/// of time, which can improve performance and reduce unnecessary load
/// on the server.
class SearchDebouncer {
  SearchDebouncer({required this.duration});

  /// The duration for which the debouncer will wait before
  /// executing the search.
  /// This helps in reducing the number of search operations by waiting for the
  /// user to stop typing for the specified duration.
  final Duration duration;

  /// A timer used to debounce search input.
  ///
  /// This timer is used to delay the execution of a function until a certain
  /// amount of time has passed since the last time the function was invoked.
  /// It helps in reducing the number of times a function is called, especially
  /// in scenarios like search fields where the function is triggered on every
  /// keystroke.
  Timer? timer;

  /// Runs the provided action after the specified duration. If a timer is
  /// already running, it will be canceled before starting a new one.
  ///
  /// The [action] parameter is a callback function that will be executed
  /// after the duration specified by the timer.
  void run(VoidCallback action) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(duration, action);
  }

  /// Cancels the current timer if it exists and resets it to null.
  /// This method is useful for stopping any ongoing debounce operation.
  void reset() {
    timer?.cancel();
    timer = null;
  }
}
