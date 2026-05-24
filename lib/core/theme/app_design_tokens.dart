import 'package:flutter/material.dart';

/// AppDesignTokens defines the semantic layout and styling constants
/// for the Radio Lumen V2 application.
class AppDesignTokens {
  AppDesignTokens._();

  // Spacing & Padding
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 12.0;
  static const double spacingL = 16.0;
  static const double spacingXL = 20.0;
  static const double spacingXXL = 24.0;
  static const double spacingXXXL = 32.0;
  static const double spacingXXXXL = 40.0;

  // Semantic Spacing
  static const double screenPadding = spacingXL; // 20.0
  static const double contentPadding = spacingL; // 16.0
  static const double elementSpacing = spacingS; // 8.0

  // Component Specific Sizes
  static const double logoSizeLarge = 180.0;
  static const double timeColumnWidth = 65.0;
  static const double navIconSize = 30.0;
  static const double archiveIconSize = 36.0;
  static const double playerIconSize = 42.0;
  static const double playerIconLargeSize = 48.0;

  // Radii
  static const double radiusXS = 4.0;
  static const double radiusS = 8.0;
  static const double radiusM = 12.0;
  static const double radiusL = 16.0;
  static const double radiusXL = 24.0;
  static const double radiusXXL = 32.0;

  // Semantic Radii
  static const double cardRadius = radiusL; // 16.0
  static const double inputRadius = radiusXXL; // 32.0 (for search bars)
  static const double buttonRadius = radiusXL; // 24.0

  // Opacities & Alphas
  static const int alphaGlassBackground = 20; // 0.08 approx
  static const int alphaGlassBorder = 25; // 0.10 approx
  static const int alphaTextSecondary = 153; // 0.60 approx
  static const int alphaTextTertiary = 128; // 0.50 approx
  static const int alphaDivider = 38; // 0.15 approx

  // Shadows
  static List<BoxShadow> get cardShadow => [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ];
}
