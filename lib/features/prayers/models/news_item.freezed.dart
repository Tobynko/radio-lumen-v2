// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'news_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$NewsItem {

 String get id; String get title; String get author; DateTime get date; String get category; String? get imageUrl; String? get content;
/// Create a copy of NewsItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NewsItemCopyWith<NewsItem> get copyWith => _$NewsItemCopyWithImpl<NewsItem>(this as NewsItem, _$identity);

  /// Serializes this NewsItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NewsItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,author,date,category,imageUrl,content);

@override
String toString() {
  return 'NewsItem(id: $id, title: $title, author: $author, date: $date, category: $category, imageUrl: $imageUrl, content: $content)';
}


}

/// @nodoc
abstract mixin class $NewsItemCopyWith<$Res>  {
  factory $NewsItemCopyWith(NewsItem value, $Res Function(NewsItem) _then) = _$NewsItemCopyWithImpl;
@useResult
$Res call({
 String id, String title, String author, DateTime date, String category, String? imageUrl, String? content
});




}
/// @nodoc
class _$NewsItemCopyWithImpl<$Res>
    implements $NewsItemCopyWith<$Res> {
  _$NewsItemCopyWithImpl(this._self, this._then);

  final NewsItem _self;
  final $Res Function(NewsItem) _then;

/// Create a copy of NewsItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? author = null,Object? date = null,Object? category = null,Object? imageUrl = freezed,Object? content = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [NewsItem].
extension NewsItemPatterns on NewsItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _NewsItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _NewsItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _NewsItem value)  $default,){
final _that = this;
switch (_that) {
case _NewsItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _NewsItem value)?  $default,){
final _that = this;
switch (_that) {
case _NewsItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String author,  DateTime date,  String category,  String? imageUrl,  String? content)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _NewsItem() when $default != null:
return $default(_that.id,_that.title,_that.author,_that.date,_that.category,_that.imageUrl,_that.content);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String author,  DateTime date,  String category,  String? imageUrl,  String? content)  $default,) {final _that = this;
switch (_that) {
case _NewsItem():
return $default(_that.id,_that.title,_that.author,_that.date,_that.category,_that.imageUrl,_that.content);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String author,  DateTime date,  String category,  String? imageUrl,  String? content)?  $default,) {final _that = this;
switch (_that) {
case _NewsItem() when $default != null:
return $default(_that.id,_that.title,_that.author,_that.date,_that.category,_that.imageUrl,_that.content);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _NewsItem implements NewsItem {
  const _NewsItem({required this.id, required this.title, required this.author, required this.date, required this.category, this.imageUrl, this.content});
  factory _NewsItem.fromJson(Map<String, dynamic> json) => _$NewsItemFromJson(json);

@override final  String id;
@override final  String title;
@override final  String author;
@override final  DateTime date;
@override final  String category;
@override final  String? imageUrl;
@override final  String? content;

/// Create a copy of NewsItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NewsItemCopyWith<_NewsItem> get copyWith => __$NewsItemCopyWithImpl<_NewsItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NewsItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NewsItem&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.author, author) || other.author == author)&&(identical(other.date, date) || other.date == date)&&(identical(other.category, category) || other.category == category)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.content, content) || other.content == content));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,author,date,category,imageUrl,content);

@override
String toString() {
  return 'NewsItem(id: $id, title: $title, author: $author, date: $date, category: $category, imageUrl: $imageUrl, content: $content)';
}


}

/// @nodoc
abstract mixin class _$NewsItemCopyWith<$Res> implements $NewsItemCopyWith<$Res> {
  factory _$NewsItemCopyWith(_NewsItem value, $Res Function(_NewsItem) _then) = __$NewsItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String author, DateTime date, String category, String? imageUrl, String? content
});




}
/// @nodoc
class __$NewsItemCopyWithImpl<$Res>
    implements _$NewsItemCopyWith<$Res> {
  __$NewsItemCopyWithImpl(this._self, this._then);

  final _NewsItem _self;
  final $Res Function(_NewsItem) _then;

/// Create a copy of NewsItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? author = null,Object? date = null,Object? category = null,Object? imageUrl = freezed,Object? content = freezed,}) {
  return _then(_NewsItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,author: null == author ? _self.author : author // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,content: freezed == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
