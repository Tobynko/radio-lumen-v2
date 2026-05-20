// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_content_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(newsContent)
final newsContentProvider = NewsContentFamily._();

final class NewsContentProvider
    extends $FunctionalProvider<AsyncValue<String>, String, FutureOr<String>>
    with $FutureModifier<String>, $FutureProvider<String> {
  NewsContentProvider._({
    required NewsContentFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'newsContentProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$newsContentHash();

  @override
  String toString() {
    return r'newsContentProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<String> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<String> create(Ref ref) {
    final argument = this.argument as String;
    return newsContent(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is NewsContentProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$newsContentHash() => r'b326565a57bd0fbba627c025b031d33d843226d3';

final class NewsContentFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<String>, String> {
  NewsContentFamily._()
    : super(
        retry: null,
        name: r'newsContentProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  NewsContentProvider call(String link) =>
      NewsContentProvider._(argument: link, from: this);

  @override
  String toString() => r'newsContentProvider';
}
