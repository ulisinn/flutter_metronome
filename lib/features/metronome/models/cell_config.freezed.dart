// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cell_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CellConfig {

 int get pulses; bool get isActive;
/// Create a copy of CellConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CellConfigCopyWith<CellConfig> get copyWith => _$CellConfigCopyWithImpl<CellConfig>(this as CellConfig, _$identity);

  /// Serializes this CellConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CellConfig&&(identical(other.pulses, pulses) || other.pulses == pulses)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pulses,isActive);

@override
String toString() {
  return 'CellConfig(pulses: $pulses, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class $CellConfigCopyWith<$Res>  {
  factory $CellConfigCopyWith(CellConfig value, $Res Function(CellConfig) _then) = _$CellConfigCopyWithImpl;
@useResult
$Res call({
 int pulses, bool isActive
});




}
/// @nodoc
class _$CellConfigCopyWithImpl<$Res>
    implements $CellConfigCopyWith<$Res> {
  _$CellConfigCopyWithImpl(this._self, this._then);

  final CellConfig _self;
  final $Res Function(CellConfig) _then;

/// Create a copy of CellConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? pulses = null,Object? isActive = null,}) {
  return _then(_self.copyWith(
pulses: null == pulses ? _self.pulses : pulses // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc

@JsonSerializable(explicitToJson: true)
class _CellConfig implements CellConfig {
  const _CellConfig({required this.pulses, this.isActive = true});
  factory _CellConfig.fromJson(Map<String, dynamic> json) => _$CellConfigFromJson(json);

@override final  int pulses;
@override@JsonKey() final  bool isActive;

/// Create a copy of CellConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CellConfigCopyWith<_CellConfig> get copyWith => __$CellConfigCopyWithImpl<_CellConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CellConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CellConfig&&(identical(other.pulses, pulses) || other.pulses == pulses)&&(identical(other.isActive, isActive) || other.isActive == isActive));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,pulses,isActive);

@override
String toString() {
  return 'CellConfig(pulses: $pulses, isActive: $isActive)';
}


}

/// @nodoc
abstract mixin class _$CellConfigCopyWith<$Res> implements $CellConfigCopyWith<$Res> {
  factory _$CellConfigCopyWith(_CellConfig value, $Res Function(_CellConfig) _then) = __$CellConfigCopyWithImpl;
@override @useResult
$Res call({
 int pulses, bool isActive
});




}
/// @nodoc
class __$CellConfigCopyWithImpl<$Res>
    implements _$CellConfigCopyWith<$Res> {
  __$CellConfigCopyWithImpl(this._self, this._then);

  final _CellConfig _self;
  final $Res Function(_CellConfig) _then;

/// Create a copy of CellConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? pulses = null,Object? isActive = null,}) {
  return _then(_CellConfig(
pulses: null == pulses ? _self.pulses : pulses // ignore: cast_nullable_to_non_nullable
as int,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
