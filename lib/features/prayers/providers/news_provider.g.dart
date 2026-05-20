// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(NewsFilter)
final newsFilterProvider = NewsFilterProvider._();

final class NewsFilterProvider extends $NotifierProvider<NewsFilter, String> {
  NewsFilterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newsFilterProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newsFilterHash();

  @$internal
  @override
  NewsFilter create() => NewsFilter();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$newsFilterHash() => r'187360be7e7bfd0f2806849259a5de9a089f8b3a';

abstract class _$NewsFilter extends $Notifier<String> {
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

@ProviderFor(news)
final newsProvider = NewsProvider._();

final class NewsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NewsItem>>,
          List<NewsItem>,
          FutureOr<List<NewsItem>>
        >
    with $FutureModifier<List<NewsItem>>, $FutureProvider<List<NewsItem>> {
  NewsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'newsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$newsHash();

  @$internal
  @override
  $FutureProviderElement<List<NewsItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NewsItem>> create(Ref ref) {
    return news(ref);
  }
}

String _$newsHash() => r'66e4c50579d853a19f8fb7fa0d27494ac122e28a';

@ProviderFor(filteredNews)
final filteredNewsProvider = FilteredNewsProvider._();

final class FilteredNewsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<NewsItem>>,
          List<NewsItem>,
          FutureOr<List<NewsItem>>
        >
    with $FutureModifier<List<NewsItem>>, $FutureProvider<List<NewsItem>> {
  FilteredNewsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'filteredNewsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$filteredNewsHash();

  @$internal
  @override
  $FutureProviderElement<List<NewsItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<NewsItem>> create(Ref ref) {
    return filteredNews(ref);
  }
}

String _$filteredNewsHash() => r'd45c85bb5a2631b4f12971ba7a75829fc86d0f8f';
