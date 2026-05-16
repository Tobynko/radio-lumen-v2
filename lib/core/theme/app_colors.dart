import 'package:flutter/material.dart';

/// AppColors defines the color palette for the Radio Lumen V2 application.
///
/// These colors are used throughout the application to ensure consistency.
class AppColors {
  AppColors._();

  // Brand Colors
  static const Color primary = Color(0xFF232D69); // Lumen Indigo
  static const Color accentGold = Color(0xFFFDBC11); // Lumen Gold
  static const Color accentTeal = Color(0xFF04A6CD); // Lumen Teal
  static const Color highlightYellow = Color(0xFFFFD754); // Bright Yellow
  static const Color supportAqua = Color(0xFF00B0AA); // Aqua

  // Background Colors (from Figma frames)
  static const Color backgroundLoading = Color(0xFF0E3F60);
  static const Color backgroundMain = Color(0xFF2B5F84);

  // Surface and Neutral
  static const Color background = Color(0xFFFEFEFE);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);

  // Status colors
  static const Color success = Color(0xFF388E3C);
  static const Color error = Color(0xFFD32F2F);
}
