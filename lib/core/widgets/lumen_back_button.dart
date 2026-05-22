import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';

/// A standardized glassmorphic back button for the Radio Lumen application.
class LumenBackButton extends StatelessWidget {
  const LumenBackButton({
    this.onTap,
    this.size = 20,
    super.key,
  });

  final VoidCallback? onTap;
  final double size;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppDesignTokens.radiusL),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () => Navigator.of(context).pop(),
          child: Container(
            padding: const EdgeInsets.all(AppDesignTokens.spacingM),
            decoration: BoxDecoration(
              color: Colors.black.withAlpha(77),
              borderRadius: BorderRadius.circular(AppDesignTokens.radiusL),
              border: Border.all(
                color: Colors.white.withAlpha(AppDesignTokens.alphaDivider),
                width: 1.5,
              ),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
              size: size,
            ),
          ),
        ),
      ),
    );
  }
}
