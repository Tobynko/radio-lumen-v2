// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quote_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_QuoteItem _$QuoteItemFromJson(Map<String, dynamic> json) => _QuoteItem(
  text: json['text'] as String,
  author: json['author'] as String,
  reference: json['reference'] as String?,
);

Map<String, dynamic> _$QuoteItemToJson(_QuoteItem instance) =>
    <String, dynamic>{
      'text': instance.text,
      'author': instance.author,
      'reference': instance.reference,
    };
