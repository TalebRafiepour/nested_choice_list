import 'dart:async';
import 'dart:ui';

class SearchDebouncer {
  SearchDebouncer({required this.duration});

  final Duration duration;
  Timer? timer;

  void run(VoidCallback action) {
    if (timer != null) {
      timer!.cancel();
    }
    timer = Timer(duration, action);
  }

  void reset() {
    timer?.cancel();
    timer = null;
  }
}
