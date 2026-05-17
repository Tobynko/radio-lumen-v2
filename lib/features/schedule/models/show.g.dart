// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'show.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Show _$ShowFromJson(Map<String, dynamic> json) => _Show(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  host: json['host'] as String?,
  imageUrl: json['image_url'] as String?,
);

Map<String, dynamic> _$ShowToJson(_Show instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'host': instance.host,
  'image_url': instance.imageUrl,
};
