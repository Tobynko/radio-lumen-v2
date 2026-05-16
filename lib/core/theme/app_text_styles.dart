import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// AppTextStyles defines the typography for the Radio Lumen V2 application.
///
/// These styles are used throughout the application to ensure consistency.
class AppTextStyles {
  AppTextStyles._();

  // Display styles (LUMEN brand font style)
  static TextStyle displayLarge = GoogleFonts.roboto(
    fontSize: 57,
    fontWeight: FontWeight.bold,
    letterSpacing: -0.25,
  );

  static TextStyle displayMedium = GoogleFonts.roboto(
    fontSize: 45,
    fontWeight: FontWeight.bold,
  );

  // Headline styles
  static TextStyle headlineLarge = GoogleFonts.roboto(
    fontSize: 32,
    fontWeight: FontWeight.w600,
  );

  static TextStyle titleLarge = GoogleFonts.roboto(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  // Body styles
  static TextStyle bodyLarge = GoogleFonts.roboto(
    fontSize: 16,
    fontWeight: FontWeight.normal,
  );

  static TextStyle bodyMedium = GoogleFonts.roboto(
    fontSize: 14,
    fontWeight: FontWeight.normal,
  );

  static TextStyle labelSmall = GoogleFonts.roboto(
    fontSize: 11,
    fontWeight: FontWeight.w400,
    color: Colors.grey,
  );
}
