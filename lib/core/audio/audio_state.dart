import 'package:freezed_annotation/freezed_annotation.dart';

part 'audio_state.freezed.dart';

enum PlaybackStatus { initial, loading, playing, paused, error }

@freezed
abstract class AudioState with _$AudioState {
  const factory AudioState({
    @Default(PlaybackStatus.initial) PlaybackStatus status,
    @Default(0.5) double volume,
    @Default(128) int quality,
    @Default(false) bool autoPlay,
    String? currentItemId,
    String? currentTitle,
    String? currentArtist,
    String? errorMessage,
  }) = _AudioState;
}
