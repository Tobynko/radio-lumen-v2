// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'archive_program.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ArchiveProgram {

 String get name; List<ArchiveEpisode> get episodes;
/// Create a copy of ArchiveProgram
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ArchiveProgramCopyWith<ArchiveProgram> get copyWith => _$ArchiveProgramCopyWithImpl<ArchiveProgram>(this as ArchiveProgram, _$identity);

  /// Serializes this ArchiveProgram to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ArchiveProgram&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other.episodes, episodes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(episodes));

@override
String toString() {
  return 'ArchiveProgram(name: $name, episodes: $episodes)';
}


}

/// @nodoc
abstract mixin class $ArchiveProgramCopyWith<$Res>  {
  factory $ArchiveProgramCopyWith(ArchiveProgram value, $Res Function(ArchiveProgram) _then) = _$ArchiveProgramCopyWithImpl;
@useResult
$Res call({
 String name, List<ArchiveEpisode> episodes
});




}
/// @nodoc
class _$ArchiveProgramCopyWithImpl<$Res>
    implements $ArchiveProgramCopyWith<$Res> {
  _$ArchiveProgramCopyWithImpl(this._self, this._then);

  final ArchiveProgram _self;
  final $Res Function(ArchiveProgram) _then;

/// Create a copy of ArchiveProgram
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? episodes = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,episodes: null == episodes ? _self.episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<ArchiveEpisode>,
  ));
}

}


/// Adds pattern-matching-related methods to [ArchiveProgram].
extension ArchiveProgramPatterns on ArchiveProgram {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ArchiveProgram value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ArchiveProgram() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ArchiveProgram value)  $default,){
final _that = this;
switch (_that) {
case _ArchiveProgram():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ArchiveProgram value)?  $default,){
final _that = this;
switch (_that) {
case _ArchiveProgram() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  List<ArchiveEpisode> episodes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ArchiveProgram() when $default != null:
return $default(_that.name,_that.episodes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  List<ArchiveEpisode> episodes)  $default,) {final _that = this;
switch (_that) {
case _ArchiveProgram():
return $default(_that.name,_that.episodes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  List<ArchiveEpisode> episodes)?  $default,) {final _that = this;
switch (_that) {
case _ArchiveProgram() when $default != null:
return $default(_that.name,_that.episodes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ArchiveProgram implements ArchiveProgram {
  const _ArchiveProgram({required this.name, required final  List<ArchiveEpisode> episodes}): _episodes = episodes;
  factory _ArchiveProgram.fromJson(Map<String, dynamic> json) => _$ArchiveProgramFromJson(json);

@override final  String name;
 final  List<ArchiveEpisode> _episodes;
@override List<ArchiveEpisode> get episodes {
  if (_episodes is EqualUnmodifiableListView) return _episodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_episodes);
}


/// Create a copy of ArchiveProgram
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ArchiveProgramCopyWith<_ArchiveProgram> get copyWith => __$ArchiveProgramCopyWithImpl<_ArchiveProgram>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ArchiveProgramToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ArchiveProgram&&(identical(other.name, name) || other.name == name)&&const DeepCollectionEquality().equals(other._episodes, _episodes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,const DeepCollectionEquality().hash(_episodes));

@override
String toString() {
  return 'ArchiveProgram(name: $name, episodes: $episodes)';
}


}

/// @nodoc
abstract mixin class _$ArchiveProgramCopyWith<$Res> implements $ArchiveProgramCopyWith<$Res> {
  factory _$ArchiveProgramCopyWith(_ArchiveProgram value, $Res Function(_ArchiveProgram) _then) = __$ArchiveProgramCopyWithImpl;
@override @useResult
$Res call({
 String name, List<ArchiveEpisode> episodes
});




}
/// @nodoc
class __$ArchiveProgramCopyWithImpl<$Res>
    implements _$ArchiveProgramCopyWith<$Res> {
  __$ArchiveProgramCopyWithImpl(this._self, this._then);

  final _ArchiveProgram _self;
  final $Res Function(_ArchiveProgram) _then;

/// Create a copy of ArchiveProgram
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? episodes = null,}) {
  return _then(_ArchiveProgram(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,episodes: null == episodes ? _self._episodes : episodes // ignore: cast_nullable_to_non_nullable
as List<ArchiveEpisode>,
  ));
}


}

// dart format on
