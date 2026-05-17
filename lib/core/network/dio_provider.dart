// Path: lib/core/network/dio_provider.dart
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'dio_client.dart';

part 'dio_provider.g.dart';

@riverpod
DioClient dioClient(Ref ref) {
  return DioClient();
}
