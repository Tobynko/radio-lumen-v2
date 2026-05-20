// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(archivePrograms)
final archiveProgramsProvider = ArchiveProgramsProvider._();

final class ArchiveProgramsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ArchiveProgram>>,
          List<ArchiveProgram>,
          FutureOr<List<ArchiveProgram>>
        >
    with
        $FutureModifier<List<ArchiveProgram>>,
        $FutureProvider<List<ArchiveProgram>> {
  ArchiveProgramsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'archiveProgramsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$archiveProgramsHash();

  @$internal
  @override
  $FutureProviderElement<List<ArchiveProgram>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ArchiveProgram>> create(Ref ref) {
    return archivePrograms(ref);
  }
}

String _$archiveProgramsHash() => r'2a4dc9362779af05887d3dc0d05710324fc20075';

@ProviderFor(ArchiveSearchQuery)
final archiveSearchQueryProvider = ArchiveSearchQueryProvider._();

final class ArchiveSearchQueryProvider
    extends $NotifierProvider<ArchiveSearchQuery, String> {
  ArchiveSearchQueryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'archiveSearchQueryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$archiveSearchQueryHash();

  @$internal
  @override
  ArchiveSearchQuery create() => ArchiveSearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$archiveSearchQueryHash() =>
    r'b5a177787e5a6c6f2fde6f3b3a0ea76147ced4bb';

abstract class _$ArchiveSearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<String, String>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<String, String>,
              String,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(filteredArchivePrograms)
final filteredArchiveProgramsProvider = FilteredArchiveProgramsProvider._();

final class FilteredArchiveProgramsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ArchiveProgram>>,
          List<ArchiveProgram>,
          FutureOr<List<ArchiveProgram>>
        >
    with
        $FutureModifier<List<ArchiveProgram>>,
        $FutureProvider<List<ArchiveProgram>> {
  FilteredArchiveProgramsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredArchiveProgramsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredArchiveProgramsHash();

  @$internal
  @override
  $FutureProviderElement<List<ArchiveProgram>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ArchiveProgram>> create(Ref ref) {
    return filteredArchivePrograms(ref);
  }
}

String _$filteredArchiveProgramsHash() =>
    r'b6748cee899418102bb56c2eed60f17d5d5cca44';
