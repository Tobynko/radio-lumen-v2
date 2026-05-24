// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'quote_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$QuoteItem {

 String get text; String get author; String? get reference;
/// Create a copy of QuoteItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteItemCopyWith<QuoteItem> get copyWith => _$QuoteItemCopyWithImpl<QuoteItem>(this as QuoteItem, _$identity);

  /// Serializes this QuoteItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteItem&&(identical(other.text, text) || other.text == text)&&(identical(other.author, author) || other.author == author)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,author,reference);

@override
String toString() {
  return 'QuoteItem(text: $text, author: $author, reference: $reference)';
}


}

/// @nodoc
abstract mixin class $QuoteItemCopyWith<$Res>  {
  factory $QuoteItemCopyWith(QuoteItem value, $Res Function(QuoteItem) _then) = _$QuoteItemCopyWithImpl;
@useResult
$Res call({
 String text, String author, String? reference
});




}
/// @nodoc
class _$QuoteItemCopyWithImpl<$Res>
    implements $QuoteItemCopyWith<$Res> {
  _$QuoteItemCopyWithImpl(this._self, this._then);

  final QuoteItem _self;
  final $Res Function(QuoteItem) _then;

/// Create a copy of QuoteItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? text = null,Object? author = null,Object? reference = freezed,}) {
  return _then(_self.copyWith(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [QuoteItem].
extension QuoteItemPatterns on QuoteItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteItem value)  $default,){
final _that = this;
switch (_that) {
case _QuoteItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteItem value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String text,  String author,  String? reference)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteItem() when $default != null:
return $default(_that.text,_that.author,_that.reference);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String text,  String author,  String? reference)  $default,) {final _that = this;
switch (_that) {
case _QuoteItem():
return $default(_that.text,_that.author,_that.reference);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String text,  String author,  String? reference)?  $default,) {final _that = this;
switch (_that) {
case _QuoteItem() when $default != null:
return $default(_that.text,_that.author,_that.reference);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteItem implements QuoteItem {
  const _QuoteItem({required this.text, required this.author, this.reference});
  factory _QuoteItem.fromJson(Map<String, dynamic> json) => _$QuoteItemFromJson(json);

@override final  String text;
@override final  String author;
@override final  String? reference;

/// Create a copy of QuoteItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteItemCopyWith<_QuoteItem> get copyWith => __$QuoteItemCopyWithImpl<_QuoteItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteItem&&(identical(other.text, text) || other.text == text)&&(identical(other.author, author) || other.author == author)&&(identical(other.reference, reference) || other.reference == reference));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,text,author,reference);

@override
String toString() {
  return 'QuoteItem(text: $text, author: $author, reference: $reference)';
}


}

/// @nodoc
abstract mixin class _$QuoteItemCopyWith<$Res> implements $QuoteItemCopyWith<$Res> {
  factory _$QuoteItemCopyWith(_QuoteItem value, $Res Function(_QuoteItem) _then) = __$QuoteItemCopyWithImpl;
@override @useResult
$Res call({
 String text, String author, String? reference
});




}
/// @nodoc
class __$QuoteItemCopyWithImpl<$Res>
    implements _$QuoteItemCopyWith<$Res> {
  __$QuoteItemCopyWithImpl(this._self, this._then);

  final _QuoteItem _self;
  final $Res Function(_QuoteItem) _then;

/// Create a copy of QuoteItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? text = null,Object? author = null,Object? reference = freezed,}) {
  return _then(_QuoteItem(
text: null == text ? _self.text : text // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,reference: freezed == reference ? _self.reference : reference // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
