import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:radio_lumen_v2/core/network/dio_client.dart';
import 'package:radio_lumen_v2/core/network/dio_provider.dart';
import 'package:radio_lumen_v2/features/schedule/models/schedule_item.dart';
import 'package:radio_lumen_v2/features/schedule/providers/schedule_provider.dart';

class FakeDioClient implements DioClient {
  @override
  Future<Map<String, dynamic>> fetchScheduleData() async {
    return {
      'data': [
        {
          'id': 'test_item_1',
          'title': 'Test Show',
          'description': 'A show for testing',
          'start_time': '2026-05-17T10:00:00.000Z',
          'endTime':
              '2026-05-17T11:00:00.000Z', // Note: JSON keys might be snake_case depending on configuration. Our previous test expected start_time, let's keep it consistent.
          // In previous models_test we saw startTime and endTime were mapped, but start_time was used for JSON.
          // Let's provide both in snake_case to be safe as per build.yaml field_rename: snake.
          'end_time': '2026-05-17T11:00:00.000Z',
          'show': {
            'id': 'show_1',
            'title': 'Show 1',
            'description': 'Show 1 description',
            'host': 'Test Host',
          },
        },
      ],
    };
  }

  @override
  Future<List<dynamic>> fetchPlaylistData() async {
    return [];
  }

  @override
  Future<String> fetchArchiveXml() async {
    return '<?xml version="1.0" encoding="utf-8"?><rss version="2.0"><channel><item><title>Test 10:00 19.05.2026</title><enclosure url="test.mp3"/></item></channel></rss>';
  }
}

void main() {
  test('scheduleProvider fetches and parses schedule data correctly', () async {
    final container = ProviderContainer(
      overrides: [dioClientProvider.overrideWithValue(FakeDioClient())],
    );

    // Ensure we dispose the container after the test
    addTearDown(container.dispose);

    // Read the future from the provider
    final scheduleItems = await container.read(scheduleProvider.future);

    expect(scheduleItems, isA<List<ScheduleItem>>());
    expect(scheduleItems.length, 1);

    final item = scheduleItems.first;
    expect(item.id, 'test_item_1');
    expect(item.title, 'Test Show');
    expect(item.startTime, DateTime.parse('2026-05-17T10:00:00.000Z'));
    expect(item.endTime, DateTime.parse('2026-05-17T11:00:00.000Z'));
    expect(item.show?.id, 'show_1');
    expect(item.show?.host, 'Test Host');
  });
}
