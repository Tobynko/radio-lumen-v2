import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_lumen_v2/core/audio/audio_controller.dart';
import 'package:radio_lumen_v2/core/audio/audio_state.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/l10n/app_localizations.dart';
import 'package:share_plus/share_plus.dart';

class QuickAccessPlayer extends ConsumerStatefulWidget {
  const QuickAccessPlayer({super.key});

  @override
  ConsumerState<QuickAccessPlayer> createState() => _QuickAccessPlayerState();
}

class _QuickAccessPlayerState extends ConsumerState<QuickAccessPlayer> {
  void _showQualityPicker() {
    final l10n = AppLocalizations.of(context)!;
    final audioState = ref.watch(audioControllerProvider);
    final controller = ref.read(audioControllerProvider.notifier);

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
                isSelected: audioState.quality == 128,
                onTap: () {
                  controller.setQuality(128);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              _QualityOption(
                label: '64 kbps',
                description: l10n.qualityMedium,
                isSelected: audioState.quality == 64,
                onTap: () {
                  controller.setQuality(64);
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 12),
              _QualityOption(
                label: '32 kbps',
                description: l10n.qualityLow,
                isSelected: audioState.quality == 32,
                onTap: () {
                  controller.setQuality(32);
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
    final audioState = ref.watch(audioControllerProvider);
    final controller = ref.read(audioControllerProvider.notifier);
    final isPlaying = audioState.status == PlaybackStatus.playing;
    final isLoading = audioState.status == PlaybackStatus.loading;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(25),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Colors.white.withAlpha(25)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(25),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Metadata
          Column(
            children: [
              Text(
                audioState.currentTitle ?? 'Rádio Lumen',
                style: AppTextStyles.titleLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              if (audioState.currentArtist != null) ...[
                const SizedBox(height: 4),
                Text(
                  audioState.currentArtist!,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withAlpha(178),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],
          ),
          const SizedBox(height: 32),
          // Volume Slider
          Row(
            children: [
              Icon(
                audioState.volume == 0 ? Icons.volume_off : Icons.volume_down,
                color: Colors.white.withAlpha(178),
                size: 20,
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.accentGold,
                    inactiveTrackColor: Colors.white.withAlpha(51),
                    thumbColor: Colors.white,
                    overlayColor: AppColors.accentGold.withAlpha(51),
                    trackHeight: 4,
                    thumbShape: const RoundSliderThumbShape(
                      enabledThumbRadius: 6,
                    ),
                  ),
                  child: Slider(
                    value: audioState.volume,
                    onChanged: (value) {
                      controller.setVolume(value);
                    },
                  ),
                ),
              ),
              Icon(
                Icons.volume_up,
                color: Colors.white.withAlpha(178),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _PlayerIconButton(
                icon: Icons.high_quality_outlined,
                onPressed: _showQualityPicker,
              ),
              // Play/Pause Button with Glow
              GestureDetector(
                onTap: () => controller.togglePlay(),
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGold,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGold.withAlpha(102),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                  child: Center(
                    child: isLoading
                        ? const CircularProgressIndicator(
                            color: AppColors.primary,
                          )
                        : Icon(
                            isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: AppColors.primary,
                            size: 48,
                          ),
                  ),
                ),
              ),
              _PlayerIconButton(
                icon: Icons.share_outlined,
                onPressed: () {
                  final title = audioState.currentTitle ?? 'Rádio Lumen';
                  final artist = audioState.currentArtist ?? '';
                  final shareText = artist.isNotEmpty
                      ? 'Práve počúvam $title od $artist na Rádiu LUMEN! 🎧 https://www.lumen.sk'
                      : 'Práve počúvam $title na Rádiu LUMEN! 🎧 https://www.lumen.sk';
                  
                  final box = context.findRenderObject() as RenderBox?;
                  SharePlus.instance.share(
                    ShareParams(
                      text: shareText,
                      sharePositionOrigin: box != null 
                          ? box.localToGlobal(Offset.zero) & box.size 
                          : null,
                    ),
                  );
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
          color: isSelected
              ? AppColors.accentGold.withAlpha(25)
              : Colors.white.withAlpha(13),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected ? AppColors.accentGold : Colors.white.withAlpha(51),
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
                      color: Colors.white.withAlpha(153),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected) const Icon(Icons.check_circle, color: AppColors.accentGold),
          ],
        ),
      ),
    );
  }
}

class _PlayerIconButton extends StatefulWidget {
  const _PlayerIconButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback onPressed;

  @override
  State<_PlayerIconButton> createState() => _PlayerIconButtonState();
}

class _PlayerIconButtonState extends State<_PlayerIconButton> {
  double _scale = 1.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _scale = 0.85),
      onTapUp: (_) => setState(() => _scale = 1.0),
      onTapCancel: () => setState(() => _scale = 1.0),
      onTap: widget.onPressed,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeInOut,
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Colors.white.withAlpha(15),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white.withAlpha(20)),
          ),
          child: Icon(
            widget.icon,
            color: Colors.white.withAlpha(204),
            size: 26,
          ),
        ),
      ),
    );
  }
}
