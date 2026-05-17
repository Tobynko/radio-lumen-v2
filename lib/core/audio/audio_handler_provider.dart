import 'package:audio_service/audio_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../main.dart';

part 'audio_handler_provider.g.dart';

@riverpod
AudioHandler audioHandlerProvider(Ref ref) {
  return audioHandler;
}
