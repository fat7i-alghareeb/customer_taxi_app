import 'package:flutter/material.dart';

/// Theme-agnostic static colors used across the app.
///
/// Use these for semantic feedback (success, warning, etc.) that do not
/// change between light and dark themes.
class AppColors {
  AppColors._();

  /// primary Color (Oxford Blue)
  // static const Color primary = Color(0xFF132e41);
  static const Color primaryLight = Color(0xFF1D0247);
  static const Color primaryDark = Color(0xFF1D0247);

  /// Secondary Color (Deep Plum/Violet Slate)
  /// Lighter than primary, used for secondary UI elements.
  static const Color secondary = Color(0xFF2A1558);
  static const Color secondaryLight = Color(0xFF2A1558);
  static const Color secondaryDark = Color(0xFF2A1558);

  /// Accent Color (Muted Amethyst)
  /// Used to make certain elements pop against the dark backgrounds.
  static const Color accent = Color(0xFF6A4C93);

  /// Platinum (Cool tinted off-white)
  static const Color platinum = Color(0xFFE5E3E8);

  /// Background Colors
  /// Light mode gets a very subtle cool tint; Dark mode is a midnight purple.
  static const Color backGroundLight = Color(0xFFF7F6F9);
  static const Color backGroundDark = Color(0xFF0E071A);

  /// Surface Colors
  /// Slightly elevated from backgrounds.
  static const Color surfaceLight = Color(0xFFF7F6F9);
  static const Color surfaceDark = Color(0xFF0E071A);

  /// Grey/Muted Colors
  /// Shifted to have slight violet undertones to blend with the theme.
  static const Color greyLight = Color(0xFFB8B3C0);
  static const Color greyDark = Color(0xFF756A8A);

  /// Color used for success/toast states (Vibrant Professional Green).
  static const Color success = Color(0xFF218356);

  /// Color used for warning states (Amber Gold).
  /// (Kept original as gold/amber is a perfect complement to deep purple).
  static const Color warning = Color(0xFFFFB703);

  /// Color used for error states (Crisp Red).
  static const Color error = Color(0xFFD90429);

  /// Color used for informational highlights (Clear Blue).
  static const Color info = Color(0xFF0077B6);
}
