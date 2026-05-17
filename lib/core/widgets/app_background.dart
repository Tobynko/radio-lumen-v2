import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';

class LumenBackground extends StatelessWidget {
  const LumenBackground({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.backgroundMain, AppColors.primary],
        ),
      ),
      child: child,
    );
  }
}
