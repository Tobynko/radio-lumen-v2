// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(schedule)
final scheduleProvider = ScheduleProvider._();

final class ScheduleProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ScheduleItem>>,
          List<ScheduleItem>,
          FutureOr<List<ScheduleItem>>
        >
    with
        $FutureModifier<List<ScheduleItem>>,
        $FutureProvider<List<ScheduleItem>> {
  ScheduleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'scheduleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$scheduleHash();

  @$internal
  @override
  $FutureProviderElement<List<ScheduleItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ScheduleItem>> create(Ref ref) {
    return schedule(ref);
  }
}

String _$scheduleHash() => r'5fe86c4990a1a1a2d3e0fb6fbd840b5e3f0859db';
