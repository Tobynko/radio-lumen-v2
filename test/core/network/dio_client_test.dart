import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radio_lumen_v2/core/network/dio_client.dart';

void main() {
  group('DioClient Tests', () {
    test('fetchScheduleData returns a Map on success', () async {
      // Arrange: create a Dio instance with an interceptor to mock responses
      final mockDio = Dio();
      
      // Mock HTML response data structure as expected by DioClient
      final mockData = {
        'tab1': '<div>19. 05. 2026</div>',
        'tab1t': '<ul class="program"><li class="item"><span class="time">08:00</span><h3>Test Show</h3><p>Description</p></li></ul>',
      };
      
      mockDio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.resolve(
              Response(
                requestOptions: options,
                data: jsonEncode(mockData),
                statusCode: 200,
              ),
            );
          },
        ),
      );

      final dioClient = DioClient(dioOverride: mockDio);

      // Act
      final result = await dioClient.fetchScheduleData();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result.containsKey('data'), isTrue);
      expect(result['data'], isA<List>());
      expect(result['data'].length, greaterThan(0));
      expect(result['data'][0]['title'], 'Test Show');
    });

    test('fetchPlaylistData returns a List on success', () async {
      // Arrange
      final mockDio = Dio();
      mockDio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.resolve(
              Response(
                requestOptions: options,
                data: [
                  {'id': 1, 'title': 'Test Song'},
                ],
                statusCode: 200,
              ),
            );
          },
        ),
      );

      final dioClient = DioClient(dioOverride: mockDio);

      // Act
      final result = await dioClient.fetchPlaylistData();

      // Assert
      expect(result, isA<List<dynamic>>());
      expect(result.length, 1);
      expect(result.first['title'], 'Test Song');
    });

    test('fetchScheduleData throws Exception on network error', () async {
      // Arrange
      final mockDio = Dio();
      mockDio.interceptors.add(
        InterceptorsWrapper(
          onRequest: (options, handler) {
            return handler.reject(
              DioException(
                requestOptions: options,
                message: 'Connection failed',
                type: DioExceptionType.connectionError,
              ),
            );
          },
        ),
      );

      final dioClient = DioClient(dioOverride: mockDio);

      // Act & Assert
      expect(
        () => dioClient.fetchScheduleData(),
        throwsA(
          isA<DioException>().having(
            (e) => e.message,
            'message',
            contains('Connection failed'),
          ),
        ),
      );
    });
  });
}
