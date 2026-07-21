import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Wraps [child] in a [Theme] whose `colorScheme.primary` is
/// [AppColors.tripOrange], so every `context.primary` / `colors.primary` below
/// it turns orange with no per-widget edits.
///
/// Scoped on purpose: the app-wide primary stays the gold brand colour. Apply
/// it at each root of the live-trip experience — the active-trip subtree, the
/// chat, the rating sheet — and separately at every sheet/dialog pushed on the
/// root navigator, since those do not inherit from the subtree that opened them.
///
/// `onPrimary` is forced to white: the orange is dark enough that the app's
/// default `onPrimary` would fail contrast on filled surfaces (chat bubbles,
/// solid buttons).
Widget tripAccentTheme(BuildContext context, {required Widget child}) {
  final theme = Theme.of(context);
  return Theme(
    data: theme.copyWith(
      colorScheme: theme.colorScheme.copyWith(
        primary: AppColors.tripOrange,
        onPrimary: Colors.white,
      ),
    ),
    child: child,
  );
}
