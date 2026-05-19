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

String _$archiveProgramsHash() => r'b98acd5ef5084c37672be36550fcc89eb2260f5c';
