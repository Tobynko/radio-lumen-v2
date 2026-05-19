import 'dart:convert';
import 'dart:developer' as developer;
import 'package:dio/dio.dart';
import 'package:html/parser.dart' show parse;

/// A production-ready HTTP client using Dio.
/// Designed to be cleanly wrapped in a Riverpod provider later.
class DioClient {
  late final Dio _dio;

  DioClient({Dio? dioOverride}) {
    _dio =
        dioOverride ??
        Dio(
          BaseOptions(
            baseUrl: 'https://api.radiolumen.sk/v2/', // Placeholder Base URL
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
            sendTimeout: const Duration(seconds: 10),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ),
        );

    // Basic logging interceptor for development and debugging
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        logPrint: (obj) => developer.log(obj.toString(), name: 'dio_client'),
      ),
    );
  }

  /// Fetches the radio schedule data by hitting the official website's AJAX API.
  Future<Map<String, dynamic>> fetchScheduleData() async {
    final items = <Map<String, dynamic>>[];

    Future<void> fetchBatch(int timestamp, int batchIndex) async {
      try {
        final response = await _dio.post<String>(
          'https://www.lumen.sk/newpages/ajax/aktualnyProgram.php',
          data: {'from': timestamp.toString(), 'root': 'https://www.lumen.sk/'},
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
            responseType: ResponseType.plain,
          ),
        );

        final Map<String, dynamic> data = jsonDecode(response.data ?? '{}');

        for (int i = 1; i <= 6; i++) {
          final tabHeaderHtml = data['tab$i']?.toString() ?? '';
          final tabContentHtml = data['tab${i}t']?.toString() ?? '';

          final headerDoc = parse(tabHeaderHtml);
          final text = headerDoc.body?.text.trim() ?? '';
          final dateMatch = RegExp(
            r'(\d{1,2})\.\s*(\d{1,2})\.\s*(\d{4})',
          ).firstMatch(text);

          if (dateMatch == null) continue;

          final date = DateTime(
            int.parse(dateMatch.group(3)!),
            int.parse(dateMatch.group(2)!),
            int.parse(dateMatch.group(1)!),
          );

          final contentDoc = parse(tabContentHtml);
          final programItems = contentDoc.querySelectorAll('ul.program > li');

          for (int j = 0; j < programItems.length; j++) {
            final li = programItems[j];
            final timeText = li.querySelector('.time')?.text.trim() ?? '';
            final title =
                li.querySelector('h3 a')?.text.trim() ??
                li.querySelector('h3')?.text.trim() ??
                '';

            final pTags = li.querySelectorAll('p');
            String description = '';
            for (final p in pTags) {
              final text = p.text.trim();
              if (text.isNotEmpty) {
                if (description.isNotEmpty) description += '\n';
                description += text;
              }
            }

            int hour = 0;
            int minute = 0;
            final timeParts = timeText.split(':');
            if (timeParts.length == 2) {
              hour = int.tryParse(timeParts[0]) ?? 0;
              minute = int.tryParse(timeParts[1]) ?? 0;
            }

            final startTime = DateTime(
              date.year,
              date.month,
              date.day,
              hour,
              minute,
            );

            final playBtn = li.querySelector('a.jp-play');
            final playUrlStr = playBtn?.attributes['rel'];

            items.add({
              'id': 'b${batchIndex}_tab${i}_$j',
              'title': title,
              'description': description,
              'start_time': startTime.toIso8601String(),
              'tags': <String>[],
              if (playUrlStr != null)
                'play_url': 'https://audiox.lumen.sk/archiv/$playUrlStr',
            });
          }
        }
      } catch (e) {
        developer.log('Error fetching batch $batchIndex: $e');
      }
    }

    try {
      final now = DateTime.now();
      // Batch 1: 2 days ago (fetches days -2, -1, 0, 1, 2, 3)
      await fetchBatch(
        now.subtract(const Duration(days: 2)).millisecondsSinceEpoch ~/ 1000,
        1,
      );
      // Batch 2: 4 days from now (fetches days 4, 5, 6, 7, 8, 9)
      await fetchBatch(
        now.add(const Duration(days: 4)).millisecondsSinceEpoch ~/ 1000,
        2,
      );

      // Calculate end times based on the next item's start time
      for (int i = 0; i < items.length; i++) {
        final startTime = DateTime.parse(items[i]['start_time'] as String);
        DateTime endTime;
        if (i < items.length - 1) {
          endTime = DateTime.parse(items[i + 1]['start_time'] as String);
          if (endTime.isBefore(startTime)) {
            endTime = endTime.add(const Duration(days: 1));
          }
        } else {
          endTime = startTime.add(const Duration(hours: 1));
        }
        items[i]['end_time'] = endTime.toIso8601String();
      }

      return {'data': items};
    } catch (e) {
      throw Exception('Failed to parse schedule: $e');
    }
  }

  /// Fetches the current playlist data.
  /// Currently returns raw data as models are not yet implemented.
  Future<List<dynamic>> fetchPlaylistData() async {
    try {
      final response = await _dio.get('playlist');
      if (response.data is List<dynamic>) {
        return response.data as List<dynamic>;
      }
      return [];
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Fetches the archive RSS feed.
  Future<String> fetchArchiveXml() async {
    try {
      final response = await _dio.get<String>(
        'https://www.lumen.sk/podcastg.html',
        options: Options(responseType: ResponseType.plain),
      );
      return response.data ?? '';
    } catch (e) {
      throw Exception('Failed to fetch archive: $e');
    }
  }

  Exception _handleError(DioException e) {
    // Basic placeholder error handling mapping
    return Exception('Network error: ${e.message ?? 'Unknown error occurred'}');
  }
}
