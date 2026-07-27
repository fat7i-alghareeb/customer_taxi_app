import 'package:customertaxi/common/imports/imports.dart';
import 'package:customertaxi/features/root/presentation/ui/screens/root_screen.dart';

/// Closes the current route, falling back to the root shell when there is
/// nothing to pop.
///
/// Routes opened from a notification tap are entered with `go`, which *replaces*
/// the stack — the destination is then the only route in the navigator. A bare
/// `pop()` there empties the navigator and leaves the user staring at a black
/// screen with no way back. Always close through this helper rather than
/// `Navigator.pop` / `context.pop` on any screen that a deep link can land on.
/// [fallbackExtra] is handed to the root route when there is nothing to pop —
/// pass a `RootTab` to choose which tab the user lands on. Ignored on the
/// normal pop path.
void safePop<T extends Object?>(
  BuildContext context, {
  T? result,
  Object? fallbackExtra,
}) {
  if (context.canPop()) {
    context.pop(result);
  } else {
    context.go(RootScreen.pagePath, extra: fallbackExtra);
  }
}
