import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:marquee/marquee.dart';
import 'package:radio_lumen_v2/core/audio/audio_controller.dart';
import 'package:radio_lumen_v2/core/audio/audio_state.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_design_tokens.dart';
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
      isScrollControlled: true,
      builder: (context) {
        return Container(
          decoration: const BoxDecoration(
            color: AppColors.primary,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
          ),
          padding: EdgeInsets.only(
            top: 24,
            left: 20, // Reduced from 24 for better fit on small screens
            right: 20,
            bottom: MediaQuery.of(context).padding.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Pull Handle for better UX and standardized look
              Container(
                width: 40,
                height: 4,
                margin: const EdgeInsets.only(bottom: 20),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(50),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              Text(
                l10n.qualityTitle,
                style: AppTextStyles.titleLarge.copyWith(
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5, // Reduced from 2.0 to prevent horizontal overflow
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final audioState = ref.watch(audioControllerProvider);
    final controller = ref.read(audioControllerProvider.notifier);
    final isPlaying = audioState.status == PlaybackStatus.playing;
    final isLoading = audioState.status == PlaybackStatus.loading;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      decoration: BoxDecoration(
        color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBackground),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(
          color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBorder),
        ),
        boxShadow: AppDesignTokens.cardShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Metadata with Marquee support
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _ScrollingText(
                text: audioState.currentTitle ?? l10n.audioStationName,
                style: AppTextStyles.titleLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              if (audioState.currentArtist != null) ...[
                const SizedBox(height: 4),
                _ScrollingText(
                  text: audioState.currentArtist!,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 24),
          // Volume Slider
          Row(
            children: [
              Icon(
                audioState.volume == 0 ? Icons.volume_off : Icons.volume_down,
                color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary),
                size: 20,
              ),
              Expanded(
                child: SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                    activeTrackColor: AppColors.accentGold,
                    inactiveTrackColor: Colors.white.withAlpha(AppDesignTokens.alphaDivider),
                    thumbColor: Colors.white,
                    overlayColor: AppColors.accentGold.withAlpha(AppDesignTokens.alphaDivider),
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
                color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary),
                size: 20,
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _PlayerIconButton(
                icon: Icons.high_quality_outlined,
                onPressed: _showQualityPicker,
              ),
              // Play/Pause Button with Glow - Scaled for better responsiveness
              GestureDetector(
                onTap: () => controller.togglePlay(),
                child: Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.accentGold,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGold.withAlpha(AppDesignTokens.alphaGlassBorder * 4),
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
                            size: 42,
                          ),
                  ),
                ),
              ),
              _PlayerIconButton(
                icon: Icons.share_outlined,
                onPressed: () {
                  final title = audioState.currentTitle ?? l10n.audioStationName;
                  final artist = audioState.currentArtist ?? '';
                  final shareText = artist.isNotEmpty
                      ? l10n.shareTextWithArtist(title, artist)
                      : l10n.shareTextTitleOnly(title);

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

class _ScrollingText extends StatelessWidget {
  const _ScrollingText({required this.text, required this.style});

  final String text;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: text, style: style),
          maxLines: 1,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: double.infinity);

        // Refined overflow detection: Use a tiny epsilon to ensure marquee triggers
        // even on sub-pixel overflows common on high-density mobile screens.
        final overflow = textPainter.width > (constraints.maxWidth - 0.1);

        if (overflow) {
          return SizedBox(
            height: textPainter.height,
            child: Marquee(
              text: text,
              style: style,
              scrollAxis: Axis.horizontal,
              crossAxisAlignment: CrossAxisAlignment.center,
              blankSpace: 40.0,
              velocity: 30.0,
              pauseAfterRound: const Duration(seconds: 3),
              startPadding: 10.0,
              accelerationDuration: const Duration(seconds: 1),
              accelerationCurve: Curves.linear,
              decelerationDuration: const Duration(milliseconds: 500),
              decelerationCurve: Curves.easeOut,
            ),
          );
        }

        return Text(
          text,
          style: style,
          textAlign: TextAlign.center,
          maxLines: 1,
        );
      },
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
              ? AppColors.accentGold.withAlpha(AppDesignTokens.alphaGlassBorder)
              : Colors.white.withAlpha(AppDesignTokens.alphaGlassBackground),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: isSelected
                ? AppColors.accentGold
                : Colors.white.withAlpha(AppDesignTokens.alphaDivider),
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
                      color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary),
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
            color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBackground),
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withAlpha(AppDesignTokens.alphaGlassBorder),
            ),
          ),
          child: Icon(
            widget.icon,
            color: Colors.white.withAlpha(AppDesignTokens.alphaTextSecondary + 50),
            size: 26,
          ),
        ),
      ),
    );
  }
}
