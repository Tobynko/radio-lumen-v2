import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:radio_lumen_v2/core/audio/audio_controller.dart';
import 'package:radio_lumen_v2/core/audio/audio_handler.dart';
import 'package:radio_lumen_v2/core/audio/audio_handler_provider.dart';
import 'package:radio_lumen_v2/core/audio/audio_state.dart';
import 'package:radio_lumen_v2/core/theme/app_colors.dart';
import 'package:radio_lumen_v2/core/theme/app_text_styles.dart';
import 'package:radio_lumen_v2/core/widgets/app_background.dart';
import 'package:radio_lumen_v2/features/schedule/models/schedule_item.dart';

class ArchivePlayerScreen extends ConsumerStatefulWidget {
  final ScheduleItem item;

  const ArchivePlayerScreen({super.key, required this.item});

  @override
  ConsumerState<ArchivePlayerScreen> createState() =>
      _ArchivePlayerScreenState();
}

class _ArchivePlayerScreenState extends ConsumerState<ArchivePlayerScreen> {
  @override
  void initState() {
    super.initState();
    // Start playback when the screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.item.playUrl != null) {
        _playArchive(
          widget.item.playUrl!,
          widget.item.title,
          widget.item.show?.host,
        );
      }
    });
  }

  Future<void> _playArchive(String url, String title, String? artist) async {
    final handler = ref.read(audioHandlerProviderProvider);
    if (handler is LumenAudioHandler) {
      await handler.setUrl(url);
    }
    await handler.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundMain,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white),
          onPressed: () {
            // When leaving the archive player, we should probably stop the archive playback
            // and optionally resume the live stream. For now, let's just pause.
            ref.read(audioHandlerProviderProvider).pause();
            context.pop();
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      body: LumenBackground(
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraints.maxHeight),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
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
                        // Archive Player Card
                        _ArchiveAccessPlayer(item: widget.item),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

class _ArchiveAccessPlayer extends ConsumerWidget {
  final ScheduleItem item;

  const _ArchiveAccessPlayer({required this.item});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final audioState = ref.watch(audioControllerProvider);

    // Check if the current playing media matches this archive item
    // For simplicity, we just use the global play state.
    final isPlaying = audioState.status == PlaybackStatus.playing;
    final isLoading = audioState.status == PlaybackStatus.loading;
    final dateStr = DateFormat('d.M.yy - HH:mm').format(item.startTime);

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
                item.title,
                style: AppTextStyles.titleLarge.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              if (item.show?.host != null) ...[
                const SizedBox(height: 8),
                Text(
                  item.show!.host!,
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: Colors.white.withAlpha(178),
                    fontSize: 18,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
              const SizedBox(height: 12),
              Text(
                dateStr,
                style: AppTextStyles.bodyMedium.copyWith(
                  color: AppColors.accentGold,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
          const SizedBox(height: 32),
          // Progress Slider
          const _ArchiveProgressBar(),
          const SizedBox(height: 24),
          // Control Buttons
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Play/Pause Button with Glow
              GestureDetector(
                onTap: () async {
                  final handler = ref.read(audioHandlerProviderProvider);
                  if (isPlaying) {
                    await handler.pause();
                  } else {
                    await handler.play();
                  }
                },
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
            ],
          ),
        ],
      ),
    );
  }
}

class _ArchiveProgressBar extends ConsumerStatefulWidget {
  const _ArchiveProgressBar();

  @override
  ConsumerState<_ArchiveProgressBar> createState() =>
      _ArchiveProgressBarState();
}

class _ArchiveProgressBarState extends ConsumerState<_ArchiveProgressBar> {
  double? _dragValue;

  @override
  Widget build(BuildContext context) {
    final handler = ref.read(audioHandlerProviderProvider);

    if (handler is! LumenAudioHandler) return const SizedBox.shrink();

    final player = handler.player;

    return StreamBuilder<Duration?>(
      stream: player.durationStream,
      builder: (context, durationSnapshot) {
        final duration = durationSnapshot.data ?? Duration.zero;

        return StreamBuilder<Duration>(
          stream: player.positionStream,
          builder: (context, positionSnapshot) {
            final position = positionSnapshot.data ?? Duration.zero;

            final safeDuration = duration.inMilliseconds > 0
                ? duration
                : const Duration(seconds: 1);
            final safePosition = position > safeDuration
                ? safeDuration
                : position;

            return Column(
              children: [
                SliderTheme(
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
                    min: 0.0,
                    max: safeDuration.inMilliseconds.toDouble(),
                    value:
                        (_dragValue ?? safePosition.inMilliseconds.toDouble())
                            .clamp(0.0, safeDuration.inMilliseconds.toDouble()),
                    onChanged: (value) {
                      setState(() {
                        _dragValue = value;
                      });
                    },
                    onChangeEnd: (value) {
                      handler.seek(Duration(milliseconds: value.round()));
                      setState(() {
                        _dragValue = null;
                      });
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _formatDuration(
                          Duration(
                            milliseconds:
                                (_dragValue ??
                                        safePosition.inMilliseconds.toDouble())
                                    .round(),
                          ),
                        ),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white.withAlpha(178),
                        ),
                      ),
                      Text(
                        _formatDuration(
                          duration.inMilliseconds > 0
                              ? duration
                              : Duration.zero,
                        ),
                        style: AppTextStyles.labelSmall.copyWith(
                          color: Colors.white.withAlpha(178),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final hours = d.inHours;
    if (hours > 0) {
      return '$hours:$minutes:$seconds';
    }
    return '$minutes:$seconds';
  }
}
