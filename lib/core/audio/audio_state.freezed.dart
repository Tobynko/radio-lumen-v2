// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AudioState {

 PlaybackStatus get status; double get volume; int get quality; bool get autoPlay; String? get currentTitle; String? get currentArtist; String? get errorMessage;
/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AudioStateCopyWith<AudioState> get copyWith => _$AudioStateCopyWithImpl<AudioState>(this as AudioState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AudioState&&(identical(other.status, status) || other.status == status)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.autoPlay, autoPlay) || other.autoPlay == autoPlay)&&(identical(other.currentTitle, currentTitle) || other.currentTitle == currentTitle)&&(identical(other.currentArtist, currentArtist) || other.currentArtist == currentArtist)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,volume,quality,autoPlay,currentTitle,currentArtist,errorMessage);

@override
String toString() {
  return 'AudioState(status: $status, volume: $volume, quality: $quality, autoPlay: $autoPlay, currentTitle: $currentTitle, currentArtist: $currentArtist, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $AudioStateCopyWith<$Res>  {
  factory $AudioStateCopyWith(AudioState value, $Res Function(AudioState) _then) = _$AudioStateCopyWithImpl;
@useResult
$Res call({
 PlaybackStatus status, double volume, int quality, bool autoPlay, String? currentTitle, String? currentArtist, String? errorMessage
});




}
/// @nodoc
class _$AudioStateCopyWithImpl<$Res>
    implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._self, this._then);

  final AudioState _self;
  final $Res Function(AudioState) _then;

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? volume = null,Object? quality = null,Object? autoPlay = null,Object? currentTitle = freezed,Object? currentArtist = freezed,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlaybackStatus,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,autoPlay: null == autoPlay ? _self.autoPlay : autoPlay // ignore: cast_nullable_to_non_nullable
as bool,currentTitle: freezed == currentTitle ? _self.currentTitle : currentTitle // ignore: cast_nullable_to_non_nullable
as String?,currentArtist: freezed == currentArtist ? _self.currentArtist : currentArtist // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [AudioState].
extension AudioStatePatterns on AudioState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AudioState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AudioState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AudioState value)  $default,){
final _that = this;
switch (_that) {
case _AudioState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AudioState value)?  $default,){
final _that = this;
switch (_that) {
case _AudioState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PlaybackStatus status,  double volume,  int quality,  bool autoPlay,  String? currentTitle,  String? currentArtist,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AudioState() when $default != null:
return $default(_that.status,_that.volume,_that.quality,_that.autoPlay,_that.currentTitle,_that.currentArtist,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PlaybackStatus status,  double volume,  int quality,  bool autoPlay,  String? currentTitle,  String? currentArtist,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _AudioState():
return $default(_that.status,_that.volume,_that.quality,_that.autoPlay,_that.currentTitle,_that.currentArtist,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PlaybackStatus status,  double volume,  int quality,  bool autoPlay,  String? currentTitle,  String? currentArtist,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _AudioState() when $default != null:
return $default(_that.status,_that.volume,_that.quality,_that.autoPlay,_that.currentTitle,_that.currentArtist,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _AudioState implements AudioState {
  const _AudioState({this.status = PlaybackStatus.initial, this.volume = 0.5, this.quality = 128, this.autoPlay = false, this.currentTitle, this.currentArtist, this.errorMessage});
  

@override@JsonKey() final  PlaybackStatus status;
@override@JsonKey() final  double volume;
@override@JsonKey() final  int quality;
@override@JsonKey() final  bool autoPlay;
@override final  String? currentTitle;
@override final  String? currentArtist;
@override final  String? errorMessage;

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AudioStateCopyWith<_AudioState> get copyWith => __$AudioStateCopyWithImpl<_AudioState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AudioState&&(identical(other.status, status) || other.status == status)&&(identical(other.volume, volume) || other.volume == volume)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.autoPlay, autoPlay) || other.autoPlay == autoPlay)&&(identical(other.currentTitle, currentTitle) || other.currentTitle == currentTitle)&&(identical(other.currentArtist, currentArtist) || other.currentArtist == currentArtist)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,status,volume,quality,autoPlay,currentTitle,currentArtist,errorMessage);

@override
String toString() {
  return 'AudioState(status: $status, volume: $volume, quality: $quality, autoPlay: $autoPlay, currentTitle: $currentTitle, currentArtist: $currentArtist, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$AudioStateCopyWith<$Res> implements $AudioStateCopyWith<$Res> {
  factory _$AudioStateCopyWith(_AudioState value, $Res Function(_AudioState) _then) = __$AudioStateCopyWithImpl;
@override @useResult
$Res call({
 PlaybackStatus status, double volume, int quality, bool autoPlay, String? currentTitle, String? currentArtist, String? errorMessage
});




}
/// @nodoc
class __$AudioStateCopyWithImpl<$Res>
    implements _$AudioStateCopyWith<$Res> {
  __$AudioStateCopyWithImpl(this._self, this._then);

  final _AudioState _self;
  final $Res Function(_AudioState) _then;

/// Create a copy of AudioState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? volume = null,Object? quality = null,Object? autoPlay = null,Object? currentTitle = freezed,Object? currentArtist = freezed,Object? errorMessage = freezed,}) {
  return _then(_AudioState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PlaybackStatus,volume: null == volume ? _self.volume : volume // ignore: cast_nullable_to_non_nullable
as double,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as int,autoPlay: null == autoPlay ? _self.autoPlay : autoPlay // ignore: cast_nullable_to_non_nullable
as bool,currentTitle: freezed == currentTitle ? _self.currentTitle : currentTitle // ignore: cast_nullable_to_non_nullable
as String?,currentArtist: freezed == currentArtist ? _self.currentArtist : currentArtist // ignore: cast_nullable_to_non_nullable
as String?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
