// Path: lib/features/schedule/models/show.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'show.freezed.dart';
part 'show.g.dart';

@freezed
abstract class Show with _$Show {
  const factory Show({
    required String id,
    required String title,
    required String description,
    String? host,
    String? imageUrl,
  }) = _Show;

  factory Show.fromJson(Map<String, dynamic> json) => _$ShowFromJson(json);
}
