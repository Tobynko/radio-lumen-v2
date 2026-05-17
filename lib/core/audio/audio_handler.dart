import 'dart:developer' as developer;
import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

class LumenAudioHandler extends BaseAudioHandler {
  final AudioPlayer _player = AudioPlayer();

  LumenAudioHandler() {
    _player.playbackEventStream.map(_transformEvent).pipe(playbackState);
    
    // Listen to ICY metadata (Icecast metadata)
    _player.icyMetadataStream.listen((icy) {
      if (icy == null) {
        developer.log('ICY Metadata is NULL', name: 'audio.metadata');
        return;
      }
      
      final infoTitle = icy.info?.title?.trim();
      final headerName = icy.headers?.name?.trim();
      
      developer.log('ICY Raw: info.title: "${icy.info?.title}", headers.name: "${icy.headers?.name}"', name: 'audio.metadata');
      
      // If infoTitle is empty or just the station name, and headerName has something, use headerName?
      // Usually infoTitle contains "Artist - Title" or just "Title"
      // headerName is usually the station name "RADIO LUMEN"
      
      String displayTitle = 'Naživo';
      String displayArtist = 'Rádio LUMEN';
      
      if (infoTitle != null && infoTitle.isNotEmpty && infoTitle.toLowerCase() != 'radio lumen') {
        displayTitle = infoTitle;
      }
      
      if (headerName != null && headerName.isNotEmpty) {
        displayArtist = headerName;
      }

      developer.log('ICY Processed: Title: $displayTitle, Artist: $displayArtist', name: 'audio.metadata');
      
      mediaItem.add(
        MediaItem(
          id: 'radio_lumen_live',
          album: 'Rádio LUMEN',
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

  Future<void> setUrl(String url) async {
    developer.log('Setting Stream URL: $url', name: 'audio.core');
    await _player.setUrl(url);
    
    // Reset to "Loading..." or "Naživo" when starting a new stream
    // but only if we don't already have real metadata (to avoid flickering)
    if (mediaItem.value == null || mediaItem.value!.title == 'Naživo') {
       mediaItem.add(
        const MediaItem(
          id: 'radio_lumen_live',
          album: 'Rádio LUMEN',
          title: 'Naživo',
          artist: 'Rádio LUMEN',
        ),
      );
    }
  }

  PlaybackState _transformEvent(PlaybackEvent event) {
    return PlaybackState(
      controls: [
        MediaControl.pause,
        MediaControl.play,
        MediaControl.stop,
      ],
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
