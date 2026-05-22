import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';

/// A standardized search bar for the Radio Lumen application.
class LumenSearchBar extends StatelessWidget {
  const LumenSearchBar({
    required this.hintText,
    this.controller,
    this.onChanged,
    this.onClear,
    super.key,
  });

  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onClear;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBorder),
        borderRadius: BorderRadius.circular(AppDesignTokens.inputRadius),
        border: Border.all(
          color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBorder),
        ),
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        style: AppTextStyles.bodyLarge.copyWith(color: Colors.white),
        cursorColor: AppColors.accentGold,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.white.withAlpha(AppDesignTokens.alphaTextTertiary),
          ),
          prefixIcon: const Icon(Icons.search, color: Colors.white70),
          suffixIcon: controller != null && controller!.text.isNotEmpty
              ? IconButton(
                  icon: const Icon(Icons.clear, color: Colors.white70),
                  onPressed: onClear,
                )
              : null,
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 12,
          ),
        ),
      ),
    );
  }
}
