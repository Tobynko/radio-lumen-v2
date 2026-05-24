import 'package:freezed_annotation/freezed_annotation.dart';

part 'quote_item.freezed.dart';
part 'quote_item.g.dart';

@freezed
abstract class QuoteItem with _$QuoteItem {
  const factory QuoteItem({
    required String text,
    required String author,
    String? reference,
  }) = _QuoteItem;

  factory QuoteItem.fromJson(Map<String, dynamic> json) => _$QuoteItemFromJson(json);
}
