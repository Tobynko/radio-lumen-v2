import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/lumen_card.dart';

/// A standardized list item for the Radio Lumen application.
///
/// Wraps a [ListTile] inside a [LumenCard] for a consistent look.
class LumenListItem extends StatelessWidget {
  const LumenListItem({
    required this.title,
    this.subtitle,
    this.trailing,
    this.leading,
    this.onTap,
    this.margin,
    super.key,
  });

  final String title;
  final String? subtitle;
  final Widget? trailing;
  final Widget? leading;
  final VoidCallback? onTap;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    return LumenCard(
      margin: margin ?? const EdgeInsets.only(bottom: 12),
      onTap: onTap,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 8,
        ),
        leading: leading,
        title: Text(
          title,
          style: AppTextStyles.titleLarge.copyWith(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: subtitle != null
            ? Text(
                subtitle!,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary),
                ),
              )
            : null,
        trailing: trailing ??
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white54,
              size: 16,
            ),
      ),
    );
  }
}
