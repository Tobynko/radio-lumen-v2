// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'archive_episode.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArchiveEpisode {

 String get title; String get originalTitle; DateTime get pubDate; String get description; String get audioUrl; String get programName;
/// Create a copy of ArchiveEpisode
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArchiveEpisodeCopyWith<ArchiveEpisode> get copyWith => _$ArchiveEpisodeCopyWithImpl<ArchiveEpisode>(this as ArchiveEpisode, _$identity);

  /// Serializes this ArchiveEpisode to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArchiveEpisode&&(identical(other.title, title) || other.title == title)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.programName, programName) || other.programName == programName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,originalTitle,pubDate,description,audioUrl,programName);

@override
String toString() {
  return 'ArchiveEpisode(title: $title, originalTitle: $originalTitle, pubDate: $pubDate, description: $description, audioUrl: $audioUrl, programName: $programName)';
}


}

/// @nodoc
abstract mixin class $ArchiveEpisodeCopyWith<$Res>  {
  factory $ArchiveEpisodeCopyWith(ArchiveEpisode value, $Res Function(ArchiveEpisode) _then) = _$ArchiveEpisodeCopyWithImpl;
@useResult
$Res call({
 String title, String originalTitle, DateTime pubDate, String description, String audioUrl, String programName
});




}
/// @nodoc
class _$ArchiveEpisodeCopyWithImpl<$Res>
    implements $ArchiveEpisodeCopyWith<$Res> {
  _$ArchiveEpisodeCopyWithImpl(this._self, this._then);

  final ArchiveEpisode _self;
  final $Res Function(ArchiveEpisode) _then;

/// Create a copy of ArchiveEpisode
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? originalTitle = null,Object? pubDate = null,Object? description = null,Object? audioUrl = null,Object? programName = null,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,programName: null == programName ? _self.programName : programName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ArchiveEpisode].
extension ArchiveEpisodePatterns on ArchiveEpisode {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArchiveEpisode value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArchiveEpisode() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArchiveEpisode value)  $default,){
final _that = this;
switch (_that) {
case _ArchiveEpisode():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArchiveEpisode value)?  $default,){
final _that = this;
switch (_that) {
case _ArchiveEpisode() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String originalTitle,  DateTime pubDate,  String description,  String audioUrl,  String programName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArchiveEpisode() when $default != null:
return $default(_that.title,_that.originalTitle,_that.pubDate,_that.description,_that.audioUrl,_that.programName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String originalTitle,  DateTime pubDate,  String description,  String audioUrl,  String programName)  $default,) {final _that = this;
switch (_that) {
case _ArchiveEpisode():
return $default(_that.title,_that.originalTitle,_that.pubDate,_that.description,_that.audioUrl,_that.programName);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String originalTitle,  DateTime pubDate,  String description,  String audioUrl,  String programName)?  $default,) {final _that = this;
switch (_that) {
case _ArchiveEpisode() when $default != null:
return $default(_that.title,_that.originalTitle,_that.pubDate,_that.description,_that.audioUrl,_that.programName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArchiveEpisode implements ArchiveEpisode {
  const _ArchiveEpisode({required this.title, required this.originalTitle, required this.pubDate, required this.description, required this.audioUrl, required this.programName});
  factory _ArchiveEpisode.fromJson(Map<String, dynamic> json) => _$ArchiveEpisodeFromJson(json);

@override final  String title;
@override final  String originalTitle;
@override final  DateTime pubDate;
@override final  String description;
@override final  String audioUrl;
@override final  String programName;

/// Create a copy of ArchiveEpisode
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArchiveEpisodeCopyWith<_ArchiveEpisode> get copyWith => __$ArchiveEpisodeCopyWithImpl<_ArchiveEpisode>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArchiveEpisodeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArchiveEpisode&&(identical(other.title, title) || other.title == title)&&(identical(other.originalTitle, originalTitle) || other.originalTitle == originalTitle)&&(identical(other.pubDate, pubDate) || other.pubDate == pubDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.audioUrl, audioUrl) || other.audioUrl == audioUrl)&&(identical(other.programName, programName) || other.programName == programName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,title,originalTitle,pubDate,description,audioUrl,programName);

@override
String toString() {
  return 'ArchiveEpisode(title: $title, originalTitle: $originalTitle, pubDate: $pubDate, description: $description, audioUrl: $audioUrl, programName: $programName)';
}


}

/// @nodoc
abstract mixin class _$ArchiveEpisodeCopyWith<$Res> implements $ArchiveEpisodeCopyWith<$Res> {
  factory _$ArchiveEpisodeCopyWith(_ArchiveEpisode value, $Res Function(_ArchiveEpisode) _then) = __$ArchiveEpisodeCopyWithImpl;
@override @useResult
$Res call({
 String title, String originalTitle, DateTime pubDate, String description, String audioUrl, String programName
});




}
/// @nodoc
class __$ArchiveEpisodeCopyWithImpl<$Res>
    implements _$ArchiveEpisodeCopyWith<$Res> {
  __$ArchiveEpisodeCopyWithImpl(this._self, this._then);

  final _ArchiveEpisode _self;
  final $Res Function(_ArchiveEpisode) _then;

/// Create a copy of ArchiveEpisode
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? originalTitle = null,Object? pubDate = null,Object? description = null,Object? audioUrl = null,Object? programName = null,}) {
  return _then(_ArchiveEpisode(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,originalTitle: null == originalTitle ? _self.originalTitle : originalTitle // ignore: cast_nullable_to_non_nullable
as String,pubDate: null == pubDate ? _self.pubDate : pubDate // ignore: cast_nullable_to_non_nullable
as DateTime,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,audioUrl: null == audioUrl ? _self.audioUrl : audioUrl // ignore: cast_nullable_to_non_nullable
as String,programName: null == programName ? _self.programName : programName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
