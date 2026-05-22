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
  StreamSubscription? _playbackSubscription;
  StreamSubscription? _mediaItemSubscription;

  @override
  AudioState build() {
    _handler = ref.watch(audioHandlerProviderProvider);
    _settings = ref.watch(settingsProviderProvider);

    _setupListeners();

    ref.onDispose(() {
      _playbackSubscription?.cancel();
      _mediaItemSubscription?.cancel();
    });

    // Watch connectivity status
    ref.listen(isOfflineProvider, (previous, next) {
      final wasOffline = previous ?? false;
      final isNowOnline = !next;

      // If we transition from offline to online AND we were supposed to be playing
      if (wasOffline && isNowOnline && state.status != PlaybackStatus.paused) {
        scheduleMicrotask(() => playLive());
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

  void _setupListeners() {
    _playbackSubscription?.cancel();
    _mediaItemSubscription?.cancel();

    _playbackSubscription = _handler.playbackState.listen((playbackState) {
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

    _mediaItemSubscription = _handler.mediaItem.listen((item) {
      if (item != null) {
        state = state.copyWith(
          currentItemId: item.id,
          currentTitle: item.title,
          currentArtist: item.artist,
        );
      }
    });
  }

  Future<void> playLive() async {
    try {
      // Set loading state immediately for UI feedback
      state = state.copyWith(status: PlaybackStatus.loading);
      
      final url = AudioEndpoints.getUrl(state.quality);

      if (_handler is LumenAudioHandler) {
        // Stop current playback (archive/rerun) before switching to live stream
        // This ensures the audio engine can clean up resources faster and prevents "freezing"
        await _handler.stop();
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

  /// Toggles playback for the Live Broadcast.
  /// 
  /// Logic (Best Practice):
  /// - If another source is active (e.g. rerun), always switch to Live broadcast in one click.
  /// - If Live is active and playing, pause it.
  /// - If Live is active and paused, resume it.
  Future<void> togglePlay() async {
    final isLiveActive = state.currentItemId == 'radio_lumen_live';
    
    if (isLiveActive && state.status == PlaybackStatus.playing) {
      await pause();
    } else {
      // Force switch to live immediately even if a rerun was playing
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

    // Only restart if the live stream is the current active source
    final isLiveActive = state.currentItemId == 'radio_lumen_live';
    if (isLiveActive && state.status == PlaybackStatus.playing) {
      await playLive(); // Restart with new quality
    }
  }

  Future<void> setAutoPlay(bool autoPlay) async {
    state = state.copyWith(autoPlay: autoPlay);
    await _settings.setAutoPlay(autoPlay);
  }
}
