import 'package:audio_service/audio_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'audio_handler.dart';
import 'audio_handler_provider.dart';
import 'audio_state.dart';
import '../network/audio_endpoints.dart';

part 'audio_controller.g.dart';

@riverpod
class AudioController extends _$AudioController {
  late AudioHandler _handler;

  @override
  AudioState build() {
    _handler = ref.watch(audioHandlerProviderProvider);
    
    // Listen to handler state changes
    _handler.playbackState.listen((playbackState) {
      final isPlaying = playbackState.playing;
      final processingState = playbackState.processingState;

      if (processingState == AudioProcessingState.loading || processingState == AudioProcessingState.buffering) {
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

    return const AudioState();
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
      state = state.copyWith(status: PlaybackStatus.error, errorMessage: e.toString());
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
  }

  Future<void> setQuality(int quality) async {
    if (state.quality == quality) return;
    
    state = state.copyWith(quality: quality);
    if (state.status == PlaybackStatus.playing) {
      await playLive(); // Restart with new quality
    }
  }
}
