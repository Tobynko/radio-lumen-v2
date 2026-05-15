import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// AppTextStyles defines the typography for the Radio Lumen V2 application.
///
/// These styles are used throughout the application to ensure consistency.
class AppTextStyles {
  AppTextStyles._();

  static TextStyle displayLarge = GoogleFonts.oswald(
    fontSize: 57,
    fontWeight: FontWeight.bold,
  );

  static TextStyle titleLarge = GoogleFonts.roboto(
    fontSize: 22,
    fontWeight: FontWeight.w500,
  );

  static TextStyle bodyMedium = GoogleFonts.openSans(fontSize: 14);

  static TextStyle labelSmall = const TextStyle(
    fontSize: 11,
    color: Colors.grey,
  );
}
