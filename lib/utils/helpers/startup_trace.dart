import 'package:flutter/foundation.dart';

import 'colored_print.dart';

/// Debug-only phase timer for [bootstrap].
///
/// Every `await` before `runApp()` extends the OS-drawn native splash, so the
/// `first-frame` mark below *is* the native splash duration — it is the number
/// startup work should be judged against.
///
/// Entirely inert in release: every method short-circuits on [kDebugMode], so
/// the stopwatch never even starts.
class StartupTrace {
  StartupTrace._();

  static final Stopwatch _stopwatch = Stopwatch();
  static int _lastElapsedMs = 0;

  /// Starts the clock. Called once at the very top of [bootstrap].
  static void begin() {
    if (!kDebugMode) return;

    _stopwatch
      ..reset()
      ..start();
    _lastElapsedMs = 0;
    printC('[StartupTrace] begin');
  }

  /// Records the time since the previous mark and since [begin].
  ///
  /// The delta is what identifies the expensive phase; the total is what tells
  /// you whether the overall budget is being met.
  static void mark(String phase) {
    if (!kDebugMode || !_stopwatch.isRunning) return;

    final total = _stopwatch.elapsedMilliseconds;
    final delta = total - _lastElapsedMs;
    _lastElapsedMs = total;

    // Slow phases are printed in a warning colour so they stand out in a busy
    // startup log without needing to read the numbers.
    final line = '[StartupTrace] $phase +${delta}ms (total ${total}ms)';
    if (delta >= 300) {
      printR(line);
    } else if (delta >= 100) {
      printY(line);
    } else {
      printG(line);
    }
  }

  /// Marks the first painted frame and stops the clock.
  static void markFirstFrame() {
    if (!kDebugMode || !_stopwatch.isRunning) return;

    mark('first-frame');
    printC(
      '[StartupTrace] native splash lasted '
      '${_stopwatch.elapsedMilliseconds}ms',
    );
    _stopwatch.stop();
  }
}
