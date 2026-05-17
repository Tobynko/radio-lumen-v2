import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';

class PrayersScreen extends StatelessWidget {
  const PrayersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: LumenBackground(
        child: Center(
          child: Text(
            AppLocalizations.of(context)!.navAktuality,
            style: AppTextStyles.titleLarge.copyWith(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
