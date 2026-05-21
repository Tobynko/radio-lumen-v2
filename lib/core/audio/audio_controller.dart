import 'dart:async';
import 'package:audio_service/audio_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'audio_handler.dart';
import 'audio_handler_provider.dart';
import 'audio_state.dart';
import '../network/audio_endpoints.dart';
import '../network/connectivity_provider.dart';
import '../settings/settings_provider.dart';

part 'audio_controller.g.dart';

@riverpod
class AudioController extends _$AudioController {
  late AudioHandler _handler;
  late SettingsProvider _settings;

  @override
  AudioState build() {
    _handler = ref.watch(audioHandlerProviderProvider);
    _settings = ref.watch(settingsProviderProvider);

    // Watch connectivity status
    ref.listen(isOfflineProvider, (previous, next) {
      final wasOffline = previous ?? false;
      final isNowOnline = !next;

      // If we transition from offline to online AND we were supposed to be playing
      if (wasOffline && isNowOnline && state.status != PlaybackStatus.paused) {
        scheduleMicrotask(() => playLive());
      }
    });

    // Listen to handler state changes
    _handler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;

      if (processingState == AudioProcessingState.loading ||
          processingState == AudioProcessingState.buffering) {
        state = state.copyWith(status: PlaybackStatus.loading);
      } else if (isPlaying) {
        state = state.copyWith(status: PlaybackStatus.playing);
      } else {
        state = state.copyWith(status: PlaybackStatus.paused);
      }
    });

    // Listen to metadata changes
    _handler.mediaItem.listen((item) {
      if (item != null) {
        state = state.copyWith(
          currentTitle: item.title,
          currentArtist: item.artist,
        );
      }
    });

    // Load initial settings
    final volume = _settings.getVolume();
    final quality = _settings.getQuality();
    final autoPlay = _settings.getAutoPlay();

    // Set initial volume on handler
    if (_handler is LumenAudioHandler) {
      (_handler as LumenAudioHandler).setVolume(volume);
    }

    if (autoPlay) {
      scheduleMicrotask(() => playLive());
    }

    return AudioState(volume: volume, quality: quality, autoPlay: autoPlay);
  }

  Future<void> playLive() async {
    try {
      state = state.copyWith(status: PlaybackStatus.loading);
      final url = AudioEndpoints.getUrl(state.quality);

      if (_handler is LumenAudioHandler) {
        await (_handler as LumenAudioHandler).setUrl(url);
      }

      await _handler.play();
    } catch (e) {
      state = state.copyWith(
        status: PlaybackStatus.error,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> pause() async {
    await _handler.pause();
  }

  Future<void> togglePlay() async {
    if (state.status == PlaybackStatus.playing) {
      await pause();
    } else {
      await playLive();
    }
  }

  Future<void> setVolume(double volume) async {
    if (_handler is LumenAudioHandler) {
      await (_handler as LumenAudioHandler).setVolume(volume);
    }
    state = state.copyWith(volume: volume);
    await _settings.setVolume(volume);
  }

  Future<void> setQuality(int quality) async {
    if (state.quality == quality) return;

    state = state.copyWith(quality: quality);
    await _settings.setQuality(quality);

    if (state.status == PlaybackStatus.playing) {
      await playLive(); // Restart with new quality
    }
  }

  Future<void> setAutoPlay(bool autoPlay) async {
    state = state.copyWith(autoPlay: autoPlay);
    await _settings.setAutoPlay(autoPlay);
  }
}
