import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:radio_lumen_v2/core/network/dio_client.dart';

void main() {
  group('DioClient Tests', () {
    test('fetchScheduleData returns a Map on success', () async {
      // Arrange: create a Dio instance with an interceptor to mock responses
      final mockDio = Dio();
      mockDio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.resolve(
            Response(
              requestOptions: options,
              data: {'status': 'success', 'schedule': []},
              statusCode: 200,
            ),
          );
        },
      ));

      final dioClient = DioClient(dioOverride: mockDio);

      // Act
      final result = await dioClient.fetchScheduleData();

      // Assert
      expect(result, isA<Map<String, dynamic>>());
      expect(result['status'], 'success');
    });

    test('fetchPlaylistData returns a List on success', () async {
      // Arrange
      final mockDio = Dio();
      mockDio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.resolve(
            Response(
              requestOptions: options,
              data: [
                {'id': 1, 'title': 'Test Song'}
              ],
              statusCode: 200,
            ),
          );
        },
      ));

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
      mockDio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          return handler.reject(
            DioException(
              requestOptions: options,
              message: 'Connection failed',
              type: DioExceptionType.connectionError,
            ),
          );
        },
      ));

      final dioClient = DioClient(dioOverride: mockDio);

      // Act & Assert
      expect(
        () => dioClient.fetchScheduleData(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Connection failed'),
          ),
        ),
      );
    });
  });
}
