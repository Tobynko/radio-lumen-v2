// Path: lib/features/archive/models/archive_program.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'archive_episode.dart';

part 'archive_program.freezed.dart';
part 'archive_program.g.dart';

@freezed
abstract class ArchiveProgram with _$ArchiveProgram {
  const factory ArchiveProgram({
    required String name,
    required List<ArchiveEpisode> episodes,
  }) = _ArchiveProgram;

  factory ArchiveProgram.fromJson(Map<String, dynamic> json) =>
      _$ArchiveProgramFromJson(json);
}
