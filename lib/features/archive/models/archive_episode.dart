// Path: lib/features/archive/models/archive_episode.dart
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:radio_lumen_v2/features/schedule/models/schedule_item.dart';
import 'package:radio_lumen_v2/features/schedule/models/show.dart';

part 'archive_episode.freezed.dart';
part 'archive_episode.g.dart';

@freezed
abstract class ArchiveEpisode with _$ArchiveEpisode {
  const factory ArchiveEpisode({
    required String title,
    required String originalTitle,
    required DateTime pubDate,
    required String description,
    required String audioUrl,
    required String programName,
  }) = _ArchiveEpisode;

  factory ArchiveEpisode.fromJson(Map<String, dynamic> json) =>
      _$ArchiveEpisodeFromJson(json);
}

extension ArchiveEpisodeMapper on ArchiveEpisode {
  ScheduleItem toScheduleItem() {
    return ScheduleItem(
      id: audioUrl,
      title: title,
      description: description,
      startTime: pubDate,
      endTime: pubDate,
      playUrl: audioUrl,
      show: Show(
        id: programName,
        title: programName,
        description: '',
      ),
    );
  }
}
