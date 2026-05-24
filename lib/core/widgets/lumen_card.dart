import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';

/// A glassmorphic card widget that follows the Radio Lumen design system.
///
/// It provides a consistent background, border, and blur effect.
class LumenCard extends StatelessWidget {
  const LumenCard({
    required this.child,
    this.padding,
    this.margin,
    this.borderRadius,
    this.onTap,
    super.key,
  });

  final Widget child;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? borderRadius;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final effectiveBorderRadius =
        borderRadius ?? AppDesignTokens.cardRadius;

    Widget current = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBackground),
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        border: Border.all(
          color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBorder),
        ),
      ),
      child: child,
    );

    if (margin != null) {
      current = Padding(
        padding: margin!,
        child: current,
      );
    }

    if (onTap != null) {
      return InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(effectiveBorderRadius),
        child: current,
      );
    }

    return current;
  }
}
