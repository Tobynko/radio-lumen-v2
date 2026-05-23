// Path: lib/features/main_shell.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_lumen_v2/core/network/connectivity_provider.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/utils/l10n_utils.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';

class MainShell extends ConsumerWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Initialize L10n utility for services
    L10n.init(context);

    final l10n = AppLocalizations.of(context)!;
    final isOffline = ref.watch(isOfflineProvider);

    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Stack(
        children: [
          navigationShell,
          if (isOffline)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: SafeArea(
                bottom: false,
                child: Container(
                  color: AppColors.error.withValues(alpha: 0.9),
                  padding: const EdgeInsets.symmetric(
                    vertical: AppDesignTokens.spacingS,
                  ),
                  child: Text(
                    l10n.connectivityOffline,
                    textAlign: TextAlign.center,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: const BorderRadius.vertical(
            top: Radius.circular(AppDesignTokens.radiusXXL),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.3),
              blurRadius: 15,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 14, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _NavButton(
                  label: l10n.navLive.toUpperCase(),
                  iconPath: 'assets/icons/live_symbol.svg',
                  isActive: navigationShell.currentIndex == 0,
                  onTap: () => _onTap(context, 0),
                ),
                _NavButton(
                  label: l10n.navProgram.toUpperCase(),
                  iconPath: 'assets/icons/programme_symbol.svg',
                  isActive: navigationShell.currentIndex == 1,
                  onTap: () => _onTap(context, 1),
                ),
                _NavButton(
                  label: l10n.navArchiv.toUpperCase(),
                  iconPath: 'assets/icons/archive_symbol.svg',
                  isActive: navigationShell.currentIndex == 2,
                  onTap: () => _onTap(context, 2),
                ),
                _NavButton(
                  label: l10n.navAktuality.toUpperCase(),
                  iconPath: 'assets/icons/news_symbol.svg',
                  isActive: navigationShell.currentIndex == 3,
                  onTap: () => _onTap(context, 3),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.label,
    required this.iconPath,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final String iconPath;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.accentGold : AppColors.navInactive;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTextStyles.labelSmall.copyWith(
              color: color,
              fontSize: 14,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: AppDesignTokens.spacingS),
          SvgPicture.asset(
            iconPath,
            width: AppDesignTokens.navIconSize,
            height: AppDesignTokens.navIconSize,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }
}
