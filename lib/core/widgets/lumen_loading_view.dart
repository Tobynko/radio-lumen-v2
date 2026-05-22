import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';

/// A standardized loading view for the Radio Lumen application.
class LumenLoadingView extends StatelessWidget {
  const LumenLoadingView({
    this.color = AppColors.accentGold,
    super.key,
  });

  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator(
        color: color,
      ),
    );
  }
}
