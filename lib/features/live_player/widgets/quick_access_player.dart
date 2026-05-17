import 'package:flutter/material.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';

class QuickAccessPlayer extends StatefulWidget {
  const QuickAccessPlayer({super.key});

  @override
  State<QuickAccessPlayer> createState() => _QuickAccessPlayerState();
}

class _QuickAccessPlayerState extends State<QuickAccessPlayer> {
  double _volume = 0.5;
  int _selectedQuality = 128; // Default to highest quality

  void _showQualityPicker() {
    final l10n = AppLocalizations.of(context)!;
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                l10n.qualityTitle,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                ),
              ),
              const SizedBox(height: 24),
              _QualityOption(
                label: '128 kbps',
                description: l10n.qualityHigh,
                isSelected: _selectedQuality == 128,
                onTap: () {
                  setState(() => _selectedQuality = 128);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              _QualityOption(
                label: '64 kbps',
                description: l10n.qualityMedium,
                isSelected: _selectedQuality == 64,
                onTap: () {
                  setState(() => _selectedQuality = 64);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              _QualityOption(
                label: '32 kbps',
                description: l10n.qualityLow,
                isSelected: _selectedQuality == 32,
                onTap: () {
                  setState(() => _selectedQuality = 32);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: const Color(
          0xFFC4C4C4,
        ).withValues(alpha: 0.8), // Greyish background from design
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            children: [
              Text(
                'SVÄTÁ OMŠA', // Placeholder title
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                'CELEBRANT: OTEC JOZEF', // Placeholder author/artist
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.primary.withValues(alpha: 0.7),
                  fontWeight: FontWeight.w500,
                  letterSpacing: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Volume Slider
          Row(
            children: [
              const Icon(Icons.volume_mute, color: AppColors.primary, size: 20),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.accentGold,
                    inactiveTrackColor: Colors.white.withValues(alpha: 0.5),
                    thumbColor: Colors.white,
                    overlayColor: AppColors.accentGold.withValues(alpha: 0.2),
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                  ),
                  child: Slider(
                    value: _volume,
                    onChanged: (value) {
                      setState(() {
                        _volume = value;
                      });
                    },
                  ),
                ),
              ),
              const Icon(Icons.volume_up, color: AppColors.primary, size: 20),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // Quality Button
              _PlayerIconButton(
                icon: Icons.high_quality,
                onPressed: _showQualityPicker,
              ),
              // Play Button
              Container(
                decoration: const BoxDecoration(shape: BoxShape.circle),
                child: IconButton(
                  onPressed: () {
                    // TODO: Implement play/pause
                  },
                  icon: const Icon(
                    Icons.play_arrow_rounded,
                    color: AppColors.primary,
                    size: 64,
                  ),
                ),
              ),
              // Share Button
              _PlayerIconButton(
                icon: Icons.share,
                onPressed: () {
                  // TODO: Implement share
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QualityOption extends StatelessWidget {
  const _QualityOption({
    required this.label,
    required this.description,
    required this.isSelected,
    required this.onTap,
  });

  final String label;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color:
              isSelected
                  ? AppColors.accentGold.withValues(alpha: 0.1)
                  : Colors.white.withValues(alpha: 0.05),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color:
                isSelected
                    ? AppColors.accentGold
                    : Colors.white.withValues(alpha: 0.2),
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTextStyles.bodyLarge.copyWith(
                      color: isSelected ? AppColors.accentGold : Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    description,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.accentGold),
          ],
        ),
      ),
    );
  }
}

class _PlayerIconButton extends StatelessWidget {
  const _PlayerIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(icon, color: AppColors.primary, size: 32),
    );
  }
}
