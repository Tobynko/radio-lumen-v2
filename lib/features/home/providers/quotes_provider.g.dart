// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quotes_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Quotes)
final quotesProvider = QuotesProvider._();

final class QuotesProvider extends $AsyncNotifierProvider<Quotes, QuoteItem> {
  QuotesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'quotesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$quotesHash();

  @$internal
  @override
  Quotes create() => Quotes();
}

String _$quotesHash() => r'd63a325581465b465d0bc17b3025cfafc86093f5';

abstract class _$Quotes extends $AsyncNotifier<QuoteItem> {
  FutureOr<QuoteItem> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<QuoteItem>, QuoteItem>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<QuoteItem>, QuoteItem>,
              AsyncValue<QuoteItem>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
