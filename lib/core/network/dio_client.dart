import 'dart:developer' as developer;
import 'package:dio/dio.dart';

/// A production-ready HTTP client using Dio.
/// Designed to be cleanly wrapped in a Riverpod provider later.
class DioClient {
  late final Dio _dio;

  DioClient({Dio? dioOverride}) {
    _dio = dioOverride ??
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

  /// Fetches the radio schedule data.
  /// Currently returns raw data as models are not yet implemented.
  Future<Map<String, dynamic>> fetchScheduleData() async {
    try {
      final response = await _dio.get('schedule');
      if (response.data is Map<String, dynamic>) {
        return response.data as Map<String, dynamic>;
      }
      return {'data': response.data};
    } on DioException catch (e) {
      throw _handleError(e);
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

  Exception _handleError(DioException e) {
    // Basic placeholder error handling mapping
    return Exception('Network error: ${e.message ?? 'Unknown error occurred'}');
  }
}
