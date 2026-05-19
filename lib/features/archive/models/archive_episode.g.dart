// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArchiveEpisode _$ArchiveEpisodeFromJson(Map<String, dynamic> json) =>
    _ArchiveEpisode(
      title: json['title'] as String,
      originalTitle: json['original_title'] as String,
      pubDate: DateTime.parse(json['pub_date'] as String),
      description: json['description'] as String,
      audioUrl: json['audio_url'] as String,
      programName: json['program_name'] as String,
    );

Map<String, dynamic> _$ArchiveEpisodeToJson(_ArchiveEpisode instance) =>
    <String, dynamic>{
      'title': instance.title,
      'original_title': instance.originalTitle,
      'pub_date': instance.pubDate.toIso8601String(),
      'description': instance.description,
      'audio_url': instance.audioUrl,
      'program_name': instance.programName,
    };
