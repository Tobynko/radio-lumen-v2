// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'archive_program.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ArchiveProgram _$ArchiveProgramFromJson(Map<String, dynamic> json) =>
    _ArchiveProgram(
      name: json['name'] as String,
      episodes: (json['episodes'] as List<dynamic>)
          .map((e) => ArchiveEpisode.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArchiveProgramToJson(_ArchiveProgram instance) =>
    <String, dynamic>{'name': instance.name, 'episodes': instance.episodes};
