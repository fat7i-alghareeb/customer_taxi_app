import 'package:flutter/foundation.dart';

/// Logs in **all** build modes.
///
/// Everything in `colored_print.dart` is wrapped in `if (kDebugMode)` and
/// `dart:developer`'s `log` routes to the VM service, which is disabled in
/// release — so neither reaches logcat on a Play Store install. `debugPrint`
/// is not debug-only despite its name: it calls `print` through a throttler,
/// which also avoids logcat's per-line truncation.
///
/// Reserve this for failures that must stay diagnosable in production.
void logAlways(String message, {Object? error, StackTrace? stackTrace}) {
  debugPrint('[fat7i] $message${error == null ? '' : ' | $error'}');
  if (stackTrace != null) debugPrint('[fat7i] $stackTrace');
}
