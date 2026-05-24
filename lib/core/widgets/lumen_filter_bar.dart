import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';

/// A standardized filter/tab bar for the Radio Lumen application.
/// 
/// Used for day selection in Schedule and categories in News.
class LumenFilterBar<T> extends StatelessWidget {
  const LumenFilterBar({
    required this.items,
    required this.selectedItem,
    required this.onSelected,
    required this.labelBuilder,
    this.height = 40,
    super.key,
  });

  final List<T> items;
  final T selectedItem;
  final ValueChanged<T> onSelected;
  final String Function(T) labelBuilder;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        padding: const EdgeInsets.symmetric(horizontal: AppDesignTokens.contentPadding),
        itemBuilder: (context, index) {
          final item = items[index];
          final isSelected = item == selectedItem;
          final label = labelBuilder(item);

          return GestureDetector(
            onTap: () => onSelected(item),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              margin: const EdgeInsets.symmetric(horizontal: AppDesignTokens.spacingXS),
              padding: const EdgeInsets.symmetric(
                horizontal: AppDesignTokens.spacingL,
                vertical: 0,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.accentGold
                    : Colors.white.withAlpha(AppDesignTokens.alphaGlassBackground),
                borderRadius: BorderRadius.circular(AppDesignTokens.radiusXL),
                border: Border.all(
                  color: isSelected
                      ? AppColors.accentGold
                      : Colors.white.withAlpha(AppDesignTokens.alphaGlassBorder),
                  width: 1,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: AppColors.accentGold.withAlpha(AppDesignTokens.alphaGlassBorder * 4),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ]
                    : null,
              ),
              child: Center(
                child: Text(
                  label.toUpperCase(),
                  style: AppTextStyles.bodyLarge.copyWith(
                    color: isSelected
                        ? AppColors.primary
                        : Colors.white.withAlpha(217),
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                    fontSize: 11,
                    letterSpacing: 1.1,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
