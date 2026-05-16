import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';

class MainShell extends StatelessWidget {
  const MainShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _onTap(BuildContext context, int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: Container(
        height: 100,
        decoration: const BoxDecoration(
          color: AppColors.backgroundLoading,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        child: SafeArea(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _NavButton(
                label: l10n.navProgram.toUpperCase(),
                iconPath: 'assets/icons/program_symbol.svg',
                activeIconPath: 'assets/icons/program_symbol_active.svg',
                isActive: navigationShell.currentIndex == 0,
                onTap: () => _onTap(context, 0),
              ),
              _NavButton(
                label: l10n.navArchiv.toUpperCase(),
                iconPath: 'assets/icons/archiv_symbol.svg',
                activeIconPath: 'assets/icons/archiv_symbol_active.svg',
                isActive: navigationShell.currentIndex == 1,
                onTap: () => _onTap(context, 1),
              ),
              _NavButton(
                label: l10n.navModlitby.toUpperCase(),
                iconPath: 'assets/icons/motlitby_symbol.svg',
                activeIconPath: 'assets/icons/motlitby_symbol_active.svg',
                isActive: navigationShell.currentIndex == 2,
                onTap: () => _onTap(context, 2),
              ),
              _NavButton(
                label: l10n.navHome.toUpperCase(),
                iconPath: 'assets/icons/live_symbol.svg',
                activeIconPath: 'assets/icons/live_symbol_active.svg',
                isActive: navigationShell.currentIndex == 3,
                onTap: () => _onTap(context, 3),
              ),
            ],
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
    required this.activeIconPath,
    required this.isActive,
    required this.onTap,
  });

  final String label;
  final String iconPath;
  final String activeIconPath;
  final bool isActive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final color = isActive ? AppColors.accentGold : const Color(0xFF6390B0);

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
              fontSize: 10,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 8),
          SvgPicture.asset(
            isActive ? activeIconPath : iconPath,
            width: 32,
            height: 32,
          ),
        ],
      ),
    );
  }
}
