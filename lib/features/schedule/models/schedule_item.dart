// Path: lib/features/schedule/models/schedule_item.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'show.dart';

part 'schedule_item.freezed.dart';
part 'schedule_item.g.dart';

@freezed
abstract class ScheduleItem with _$ScheduleItem {
  const factory ScheduleItem({
    required String id,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
    Show? show,
  }) = _ScheduleItem;

  factory ScheduleItem.fromJson(Map<String, dynamic> json) => _$ScheduleItemFromJson(json);
}
