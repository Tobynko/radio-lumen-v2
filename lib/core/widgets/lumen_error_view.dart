import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';

/// A standardized error view for the Radio Lumen application.
class LumenErrorView extends StatelessWidget {
  const LumenErrorView({
    required this.message,
    this.onRetry,
    super.key,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppDesignTokens.spacingXXL),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.error_outline_rounded,
              color: Colors.white54,
              size: 48,
            ),
            const SizedBox(height: AppDesignTokens.spacingL),
            Text(
              message,
              style: AppTextStyles.bodyLarge.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),
            if (onRetry != null) ...[
              const SizedBox(height: AppDesignTokens.spacingXL),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('SKÚSIŤ ZNOVA'),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
