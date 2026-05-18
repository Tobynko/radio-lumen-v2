// Path: lib/features/schedule/providers/schedule_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:radio_lumen_v2/core/network/dio_provider.dart';
import 'package:radio_lumen_v2/features/schedule/models/schedule_item.dart';

part 'schedule_provider.g.dart';

@riverpod
Future<List<ScheduleItem>> schedule(Ref ref) async {
  final dioClient = ref.watch(dioClientProvider);
  final rawData = await dioClient.fetchScheduleData();

  // As the final API JSON response schema is not strictly defined,
  // we assume the list of schedule items is under a 'data' key.
  // We fall back to an empty list if not found.
  final itemsList = rawData['data'] as List<dynamic>? ?? [];

  return itemsList
      .map((item) => ScheduleItem.fromJson(item as Map<String, dynamic>))
      .toList();
}
