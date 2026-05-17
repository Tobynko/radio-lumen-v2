// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_handler_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(audioHandlerProvider)
final audioHandlerProviderProvider = AudioHandlerProviderProvider._();

final class AudioHandlerProviderProvider
    extends $FunctionalProvider<AudioHandler, AudioHandler, AudioHandler>
    with $Provider<AudioHandler> {
  AudioHandlerProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'audioHandlerProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$audioHandlerProviderHash();

  @$internal
  @override
  $ProviderElement<AudioHandler> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AudioHandler create(Ref ref) {
    return audioHandlerProvider(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AudioHandler value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AudioHandler>(value),
    );
  }
}

String _$audioHandlerProviderHash() =>
    r'4dc860190d020cad3f1c6a8022ee04bc4a348362';
