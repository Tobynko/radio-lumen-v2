// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'news_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NewsItem _$NewsItemFromJson(Map<String, dynamic> json) => _NewsItem(
  id: json['id'] as String,
  title: json['title'] as String,
  author: json['author'] as String,
  date: DateTime.parse(json['date'] as String),
  category: json['category'] as String,
  imageUrl: json['image_url'] as String?,
  content: json['content'] as String?,
);

Map<String, dynamic> _$NewsItemToJson(_NewsItem instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'author': instance.author,
  'date': instance.date.toIso8601String(),
  'category': instance.category,
  'image_url': instance.imageUrl,
  'content': instance.content,
};
