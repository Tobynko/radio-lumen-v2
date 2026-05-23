import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';

/// A standardized error view for the Radio Lumen application.
/// 
/// Note: This view does not include a retry button as the application
/// uses reactive providers that automatically re-fetch data when 
/// connectivity is restored.
class LumenErrorView extends StatelessWidget {
  const LumenErrorView({
    required this.message,
    super.key,
  });

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spacingL), // Reduced from XXL
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.white54,
              size: 40, // Reduced from 48 for better fit
            ),
            const SizedBox(height: AppDesignTokens.spacingM),
            Text(
              message,
              style: AppTextStyles.bodyMedium.copyWith( // Using bodyMedium for better fit
                color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary),
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
