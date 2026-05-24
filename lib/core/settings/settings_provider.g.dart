// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'settings_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(settingsProvider)
final settingsProviderProvider = SettingsProviderProvider._();

final class SettingsProviderProvider
    extends
        $FunctionalProvider<
          SettingsProvider,
          SettingsProvider,
          SettingsProvider
        >
    with $Provider<SettingsProvider> {
  SettingsProviderProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'settingsProviderProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$settingsProviderHash();

  @$internal
  @override
  $ProviderElement<SettingsProvider> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  SettingsProvider create(Ref ref) {
    return settingsProvider(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SettingsProvider value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SettingsProvider>(value),
    );
  }
}

String _$settingsProviderHash() => r'9d06f7addc2413afd078505b6d5fadcca128814b';
