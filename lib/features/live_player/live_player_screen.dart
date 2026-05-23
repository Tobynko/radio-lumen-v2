import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_lumen_v2/core/settings/language_provider.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/features/live_player/widgets/quick_access_player.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class LivePlayerScreen extends ConsumerWidget {
  const LivePlayerScreen({super.key});

  void _showAboutSheet(BuildContext context) async {
    final packageInfo = await PackageInfo.fromPlatform();
    final version = packageInfo.version;

    if (!context.mounted) return;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) => _AboutSheetContent(version: version),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      body: LumenBackground(
        child: SafeArea(
          child: Stack(
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraints.maxHeight),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDesignTokens.screenPadding,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 40),
                            // Logo Section
                            Center(
                              child: Image.asset(
                                'assets/logos/logo.png',
                                height: 180,
                              ),
                            ),
                            const SizedBox(height: 40),
                            // Quick Access Player Card
                            const QuickAccessPlayer(),
                            const SizedBox(height: 40),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
              // Info Icon
              Positioned(
                top: AppDesignTokens.spacingS,
                right: AppDesignTokens.spacingL,
                child: IconButton(
                  icon: const Icon(
                    Icons.info_outline_rounded,
                    color: Colors.white70,
                    size: 28,
                  ),
                  onPressed: () => _showAboutSheet(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AboutSheetContent extends ConsumerWidget {
  final String version;

  const _AboutSheetContent({required this.version});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watching the language provider ensures this entire widget rebuilds
    // when the language is changed via the selector below.
    ref.watch(languageProvider);
    final l10n = AppLocalizations.of(context)!;

    return Container(
      decoration: const BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(AppDesignTokens.radiusXXL),
        ),
      ),
      padding: EdgeInsets.only(
        top: AppDesignTokens.spacingXXL,
        left: AppDesignTokens.screenPadding,
        right: AppDesignTokens.screenPadding,
        bottom:
            MediaQuery.of(context).padding.bottom + AppDesignTokens.spacingXXL,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Pull Handle
          Container(
            width: 40,
            height: 4,
            margin: const EdgeInsets.only(bottom: AppDesignTokens.spacingXXXL),
            decoration: BoxDecoration(
              color: Colors.white.withAlpha(50),
              borderRadius: BorderRadius.circular(AppDesignTokens.radiusXS),
            ),
          ),

          Text(
            l10n.aboutTitle,
            style: AppTextStyles.headlineLarge.copyWith(
              color: AppColors.accentGold,
              fontWeight: FontWeight.bold,
              fontSize: 28,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDesignTokens.spacingS),
          Text(
            l10n.aboutVersion(version),
            style: AppTextStyles.bodyMedium.copyWith(
              color: Colors.white70,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppDesignTokens.spacingXXXL),

          // Flexible scroll area
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Language Selector Section
                  const _LanguageSelector(),
                  const SizedBox(height: AppDesignTokens.spacingXXL),

                  // Links Section
                  _AboutLinkItem(
                    label: l10n.aboutLumenClub,
                    icon: Icons.stars_rounded,
                    onTap: () =>
                        _launchUrl('https://www.lumen.sk/lumen-klub.html'),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingM),
                  _AboutLinkItem(
                    label: l10n.aboutContactUs,
                    icon: Icons.email_outlined,
                    onTap: () => _launchUrl('https://www.lumen.sk/kontakty.html'),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingM),
                  _AboutLinkItem(
                    label: l10n.aboutPrivacyPolicy,
                    icon: Icons.privacy_tip_outlined,
                    onTap: () => _launchUrl(
                        'https://www.lumen.sk/ochrana-osobnych-udajov.html'),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingXXXL),

                  // Developers Section
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(AppDesignTokens.spacingXL),
                    decoration: BoxDecoration(
                      color: Colors.white.withAlpha(15),
                      borderRadius:
                          BorderRadius.circular(AppDesignTokens.radiusXL),
                      border: Border.all(
                        color: Colors.white.withAlpha(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          l10n.aboutDevelopedBy.toUpperCase(),
                          style: AppTextStyles.labelSmall.copyWith(
                            color: AppColors.accentGold,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: AppDesignTokens.spacingM),
                        Text(
                          'Bc. Tobiáš Bulko',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: AppDesignTokens.spacingXS),
                        Text(
                          'Bc. Janka Danišová',
                          style: AppTextStyles.bodyLarge.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppDesignTokens.spacingXXXL),

                  // Copyright
                  Text(
                    l10n.aboutCopyright,
                    style: AppTextStyles.labelSmall.copyWith(
                      color: Colors.white38,
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppDesignTokens.spacingS),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageSelector extends ConsumerWidget {
  const _LanguageSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(languageProvider);
    final l10n = AppLocalizations.of(context)!;

    final languages = [
      {'code': 'sk', 'label': 'SK', 'flag': '🇸🇰'},
      {'code': 'en', 'label': 'EN', 'flag': '🇬🇧'},
      {'code': 'hu', 'label': 'HU', 'flag': '🇭🇺'},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding:
              const EdgeInsets.only(left: 4, bottom: AppDesignTokens.spacingM),
          child: Text(
            l10n.aboutLanguage.toUpperCase(),
            style: AppTextStyles.labelSmall.copyWith(
              color: Colors.white60,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.0,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: languages.map((lang) {
            final isSelected = currentLocale.languageCode == lang['code'];
            return Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppDesignTokens.spacingXS),
                child: GestureDetector(
                  onTap: () {
                    ref
                        .read(languageProvider.notifier)
                        .setLanguage(lang['code']!);
                  },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    padding: const EdgeInsets.symmetric(
                        vertical: AppDesignTokens.spacingM),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? AppColors.accentGold
                          : Colors.white.withAlpha(15),
                      borderRadius:
                          BorderRadius.circular(AppDesignTokens.radiusM),
                      border: Border.all(
                        color: isSelected
                            ? AppColors.accentGold
                            : Colors.white.withAlpha(10),
                      ),
                    ),
                    child: Column(
                      children: [
                        Text(
                          lang['flag']!,
                          style: const TextStyle(fontSize: 20),
                        ),
                        const SizedBox(height: AppDesignTokens.spacingXS),
                        Text(
                          lang['label']!,
                          style: AppTextStyles.bodyMedium.copyWith(
                            color: isSelected ? AppColors.primary : Colors.white,
                            fontWeight:
                                isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

class _AboutLinkItem extends StatelessWidget {
  const _AboutLinkItem({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDesignTokens.screenPadding,
          vertical: AppDesignTokens.spacingL,
        ),
        decoration: BoxDecoration(
          color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBackground),
          borderRadius: BorderRadius.circular(AppDesignTokens.radiusL),
          border: Border.all(
            color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBorder),
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: AppColors.accentGold, size: 24),
            const SizedBox(width: AppDesignTokens.spacingL),
            Expanded(
              child: Text(
                label,
                style: AppTextStyles.bodyLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios,
              color: Colors.white30,
              size: 14,
            ),
          ],
        ),
      ),
    );
  }
}
