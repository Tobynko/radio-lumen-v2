import 'package:just_audio/just_audio.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'audio_state.dart';
import '../network/audio_endpoints.dart';

part 'audio_controller.g.dart';

@riverpod
class AudioController extends _$AudioController {
  late AudioPlayer _player;

  @override
  AudioState build() {
    _player = AudioPlayer();
    
    // Listen to player state changes
    _player.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;

      if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
        state = state.copyWith(status: PlaybackStatus.loading);
      } else if (isPlaying) {
        state = state.copyWith(status: PlaybackStatus.playing);
      } else {
        state = state.copyWith(status: PlaybackStatus.paused);
      }
    }, onError: (Object e) {
      state = state.copyWith(status: PlaybackStatus.error, errorMessage: e.toString());
    });

    ref.onDispose(() {
      _player.dispose();
    });

    return const AudioState();
  }

  Future<void> playLive() async {
    try {
      state = state.copyWith(status: PlaybackStatus.loading);
      final url = AudioEndpoints.getUrl(state.quality);
      // For live streams, we use LockCachingAudioSource or just setUrl
      await _player.setUrl(url);
      await _player.play();
    } catch (e) {
      state = state.copyWith(status: PlaybackStatus.error, errorMessage: e.toString());
    }
  }

  Future<void> pause() async {
    await _player.pause();
  }

  Future<void> togglePlay() async {
    if (state.status == PlaybackStatus.playing) {
      await pause();
    } else {
      await playLive();
    }
  }

  Future<void> setVolume(double volume) async {
    await _player.setVolume(volume);
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
