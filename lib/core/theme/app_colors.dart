import 'package:flutter/material.dart';

/// Theme-agnostic static colors used across the app.
///
/// Use these for semantic feedback (success, warning, etc.) that do not
/// change between light and dark themes.
class AppColors {
  AppColors._();

  /// primary Color (Oxford Blue)
  // static const Color primary = Color(0xFF132e41);
  static const Color primaryLight = Color(0xFF132e41);
  static const Color primaryDark = Color(0xFF2B658E);

  /// Secondary Color (Deep Slate)
  static const Color secondary = Color(0xFF1B263B);
  static const Color secondaryLight = Color(0xFF1B263B);
  static const Color secondaryDark = Color(0xFF1B263B);

  /// Accent Color (Muted Blue / Platinum)
  static const Color accent = Color(0xFF415A77);
  static const Color platinum = Color(0xFFE0E1DD);

  /// Background Colors
  static const Color backGroundLight = Color(0xFFF8F9FA);
  static const Color backGroundDark = Color(0xFF161A1D);

  /// Surface Colors
  static const Color surfaceLight = Color(0xFFF8F9FA);
  static const Color surfaceDark = Color(0xFF161A1D);

  /// Grey/Muted Colors
  static const Color greyLight = Color.fromARGB(255, 179, 182, 185);
  static const Color greyDark = Color(0xFF778DA9);

  /// Color used for success/toast states (Professional Emerald).
  static const Color success = Color(0xFF2D6A4F);

  /// Color used for warning states (Amber Gold).
  static const Color warning = Color(0xFFFFB703);

  /// Color used for error states (Ruby Red).
  static const Color error = Color(0xFF9A031E);

  /// Color used for informational highlights (Pacific Blue).
  static const Color info = Color(0xFF1D3557);
}
