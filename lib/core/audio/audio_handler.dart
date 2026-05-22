import 'dart:convert';
import 'dart:developer' as developer;
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';
import 'package:radio_lumen_v2/core/utils/l10n_utils.dart';

class LumenAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  AudioPlayer get player => _player;

  LumenAudioHandler() {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);

    // Listen to duration changes (especially for archive/VOD)
    _player.durationStream.listen((duration) {
      final currentItem = mediaItem.value;
      if (currentItem != null && duration != null) {
        mediaItem.add(currentItem.copyWith(duration: duration));
      }
    });

    // Listen to ICY metadata (Icecast metadata)
    _player.icyMetadataStream.listen((icy) {
      if (icy == null) {
        return;
      }

      final rawTitle = icy.info?.title?.trim();
      final headerName = icy.headers?.name?.trim();

      // Fix encoding: Common issue where UTF-8 bytes are misread as Latin-1
      String? infoTitle;
      if (rawTitle != null) {
        try {
          // Re-decode the string code units as UTF-8 bytes
          // This fixes characters like Ä¾ -> ľ
          infoTitle = utf8.decode(rawTitle.codeUnits);
        } catch (_) {
          infoTitle = rawTitle;
        }
      }

      final l10n = L10n.instance;
      String displayTitle = l10n.audioLiveTitle;
      String displayArtist = headerName ?? l10n.audioStationName;

      if (infoTitle != null && infoTitle.isNotEmpty) {
        // Try to split "Author - Title" or "Artist - Song"
        if (infoTitle.contains(' - ')) {
          final parts = infoTitle.split(' - ');
          if (parts.length >= 2) {
            displayArtist = parts[0].trim();
            displayTitle = parts[1].trim();
          } else {
            displayTitle = infoTitle;
          }
        } else {
          displayTitle = infoTitle;
        }
      }

      // If after parsing, the title is still just the station name, use "Naživo"
      if (displayTitle.toLowerCase() == 'radio lumen') {
        displayTitle = l10n.audioLiveTitle;
      }

      mediaItem.add(
        MediaItem(
          id: 'radio_lumen_live',
          album: l10n.audioStationName,
          title: displayTitle,
          artist: displayArtist,
        ),
      );
    });
  }

  @override
  Future<void> play() => _player.play();

  @override
  Future<void> pause() => _player.pause();

  @override
  Future<void> stop() => _player.stop();

  @override
  Future<void> seek(Duration position) => _player.seek(position);

  Future<void> setVolume(double volume) => _player.setVolume(volume);

  Future<void> setUrl(String url, {MediaItem? item}) async {
    developer.log('Setting Stream URL: $url', name: 'audio.core');
    await _player.setUrl(url);

    if (item != null) {
      mediaItem.add(item);
    } else if (mediaItem.value == null ||
        mediaItem.value!.id != 'radio_lumen_live') {
      // Default to localized title/artist if it's not already set or it was something else (like archive)
      final l10n = L10n.instance;
      mediaItem.add(
        MediaItem(
          id: 'radio_lumen_live',
          album: l10n.audioStationName,
          title: l10n.audioLiveTitle,
          artist: l10n.audioStationName,
        ),
      );
    }
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [MediaControl.pause, MediaControl.play, MediaControl.stop],
      systemActions: const {
        MediaAction.seek,
        MediaAction.seekForward,
        MediaAction.seekBackward,
      },
      androidCompactActionIndices: const [0, 1, 2],
      processingState: const {
        ProcessingState.idle: AudioProcessingState.idle,
        ProcessingState.loading: AudioProcessingState.loading,
        ProcessingState.buffering: AudioProcessingState.buffering,
        ProcessingState.ready: AudioProcessingState.ready,
        ProcessingState.completed: AudioProcessingState.completed,
      }[_player.processingState]!,
      playing: _player.playing,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: _player.speed,
      queueIndex: event.currentIndex,
    );
  }
}
