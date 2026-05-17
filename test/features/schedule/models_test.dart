import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:radio_lumen_v2/features/schedule/models/show.dart';
import 'package:radio_lumen_v2/features/schedule/models/schedule_item.dart';

void main() {
  group('Schedule Models Serialization and Equality', () {
    final mockShow = const Show(
      id: 'show1',
      title: 'Morning Prayer',
      description: 'Start your day with prayer.',
      host: 'Fr. John',
      imageUrl: 'https://example.com/image.jpg',
    );

    final mockScheduleItem = ScheduleItem(
      id: 'item1',
      title: 'Morning Show',
      description: 'Morning broadcast',
      startTime: DateTime.parse('2026-05-17T08:00:00.000Z'),
      endTime: DateTime.parse('2026-05-17T09:00:00.000Z'),
      show: mockShow,
    );

    test('Show serialization and deserialization', () {
      // Use jsonDecode/jsonEncode to simulate proper API JSON map
      final json = jsonDecode(jsonEncode(mockShow.toJson()));
      expect(json['id'], 'show1');
      expect(json['title'], 'Morning Prayer');
      expect(json['host'], 'Fr. John');

      final fromJsonShow = Show.fromJson(json);
      expect(fromJsonShow, equals(mockShow));
    });

    test('ScheduleItem serialization and deserialization', () {
      final json = jsonDecode(jsonEncode(mockScheduleItem.toJson()));
      expect(json['id'], 'item1');
      expect(json['title'], 'Morning Show');
      expect(json['show']['id'], 'show1');
      expect(json['start_time'], '2026-05-17T08:00:00.000Z');

      final fromJsonItem = ScheduleItem.fromJson(json);
      expect(fromJsonItem, equals(mockScheduleItem));
    });

    test('Value equality check', () {
      final showCopy = const Show(
        id: 'show1',
        title: 'Morning Prayer',
        description: 'Start your day with prayer.',
        host: 'Fr. John',
        imageUrl: 'https://example.com/image.jpg',
      );

      expect(mockShow, equals(showCopy));
      expect(mockShow.hashCode, equals(showCopy.hashCode));
    });
  });
}
