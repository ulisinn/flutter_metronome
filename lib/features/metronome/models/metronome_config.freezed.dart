// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'metronome_config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MetronomeConfig {

 String? get id; String? get title; double get initialBpm; List<CellConfig> get cellSequence; double get strongBeatVolume; double get weakBeatVolume; bool get useCountdownTimer; int get countdownDurationSeconds; bool get markDownbeat;
/// Create a copy of MetronomeConfig
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MetronomeConfigCopyWith<MetronomeConfig> get copyWith => _$MetronomeConfigCopyWithImpl<MetronomeConfig>(this as MetronomeConfig, _$identity);

  /// Serializes this MetronomeConfig to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MetronomeConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.initialBpm, initialBpm) || other.initialBpm == initialBpm)&&const DeepCollectionEquality().equals(other.cellSequence, cellSequence)&&(identical(other.strongBeatVolume, strongBeatVolume) || other.strongBeatVolume == strongBeatVolume)&&(identical(other.weakBeatVolume, weakBeatVolume) || other.weakBeatVolume == weakBeatVolume)&&(identical(other.useCountdownTimer, useCountdownTimer) || other.useCountdownTimer == useCountdownTimer)&&(identical(other.countdownDurationSeconds, countdownDurationSeconds) || other.countdownDurationSeconds == countdownDurationSeconds)&&(identical(other.markDownbeat, markDownbeat) || other.markDownbeat == markDownbeat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,initialBpm,const DeepCollectionEquality().hash(cellSequence),strongBeatVolume,weakBeatVolume,useCountdownTimer,countdownDurationSeconds,markDownbeat);

@override
String toString() {
  return 'MetronomeConfig(id: $id, title: $title, initialBpm: $initialBpm, cellSequence: $cellSequence, strongBeatVolume: $strongBeatVolume, weakBeatVolume: $weakBeatVolume, useCountdownTimer: $useCountdownTimer, countdownDurationSeconds: $countdownDurationSeconds, markDownbeat: $markDownbeat)';
}


}

/// @nodoc
abstract mixin class $MetronomeConfigCopyWith<$Res>  {
  factory $MetronomeConfigCopyWith(MetronomeConfig value, $Res Function(MetronomeConfig) _then) = _$MetronomeConfigCopyWithImpl;
@useResult
$Res call({
 String? id, String? title, double initialBpm, List<CellConfig> cellSequence, double strongBeatVolume, double weakBeatVolume, bool useCountdownTimer, int countdownDurationSeconds, bool markDownbeat
});




}
/// @nodoc
class _$MetronomeConfigCopyWithImpl<$Res>
    implements $MetronomeConfigCopyWith<$Res> {
  _$MetronomeConfigCopyWithImpl(this._self, this._then);

  final MetronomeConfig _self;
  final $Res Function(MetronomeConfig) _then;

/// Create a copy of MetronomeConfig
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? title = freezed,Object? initialBpm = null,Object? cellSequence = null,Object? strongBeatVolume = null,Object? weakBeatVolume = null,Object? useCountdownTimer = null,Object? countdownDurationSeconds = null,Object? markDownbeat = null,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,initialBpm: null == initialBpm ? _self.initialBpm : initialBpm // ignore: cast_nullable_to_non_nullable
as double,cellSequence: null == cellSequence ? _self.cellSequence : cellSequence // ignore: cast_nullable_to_non_nullable
as List<CellConfig>,strongBeatVolume: null == strongBeatVolume ? _self.strongBeatVolume : strongBeatVolume // ignore: cast_nullable_to_non_nullable
as double,weakBeatVolume: null == weakBeatVolume ? _self.weakBeatVolume : weakBeatVolume // ignore: cast_nullable_to_non_nullable
as double,useCountdownTimer: null == useCountdownTimer ? _self.useCountdownTimer : useCountdownTimer // ignore: cast_nullable_to_non_nullable
as bool,countdownDurationSeconds: null == countdownDurationSeconds ? _self.countdownDurationSeconds : countdownDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,markDownbeat: null == markDownbeat ? _self.markDownbeat : markDownbeat // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc

@JsonSerializable(explicitToJson: true)
class _MetronomeConfig implements MetronomeConfig {
  const _MetronomeConfig({this.id, this.title, this.initialBpm = 120.0, required final  List<CellConfig> cellSequence, this.strongBeatVolume = MetronomeVolume.strongBeatVolume, this.weakBeatVolume = MetronomeVolume.weakBeatVolume, this.useCountdownTimer = false, this.countdownDurationSeconds = 300, this.markDownbeat = true}): _cellSequence = cellSequence;
  factory _MetronomeConfig.fromJson(Map<String, dynamic> json) => _$MetronomeConfigFromJson(json);

@override final  String? id;
@override final  String? title;
@override@JsonKey() final  double initialBpm;
 final  List<CellConfig> _cellSequence;
@override List<CellConfig> get cellSequence {
  if (_cellSequence is EqualUnmodifiableListView) return _cellSequence;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_cellSequence);
}

@override@JsonKey() final  double strongBeatVolume;
@override@JsonKey() final  double weakBeatVolume;
@override@JsonKey() final  bool useCountdownTimer;
@override@JsonKey() final  int countdownDurationSeconds;
@override@JsonKey() final  bool markDownbeat;

/// Create a copy of MetronomeConfig
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MetronomeConfigCopyWith<_MetronomeConfig> get copyWith => __$MetronomeConfigCopyWithImpl<_MetronomeConfig>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MetronomeConfigToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MetronomeConfig&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.initialBpm, initialBpm) || other.initialBpm == initialBpm)&&const DeepCollectionEquality().equals(other._cellSequence, _cellSequence)&&(identical(other.strongBeatVolume, strongBeatVolume) || other.strongBeatVolume == strongBeatVolume)&&(identical(other.weakBeatVolume, weakBeatVolume) || other.weakBeatVolume == weakBeatVolume)&&(identical(other.useCountdownTimer, useCountdownTimer) || other.useCountdownTimer == useCountdownTimer)&&(identical(other.countdownDurationSeconds, countdownDurationSeconds) || other.countdownDurationSeconds == countdownDurationSeconds)&&(identical(other.markDownbeat, markDownbeat) || other.markDownbeat == markDownbeat));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,initialBpm,const DeepCollectionEquality().hash(_cellSequence),strongBeatVolume,weakBeatVolume,useCountdownTimer,countdownDurationSeconds,markDownbeat);

@override
String toString() {
  return 'MetronomeConfig(id: $id, title: $title, initialBpm: $initialBpm, cellSequence: $cellSequence, strongBeatVolume: $strongBeatVolume, weakBeatVolume: $weakBeatVolume, useCountdownTimer: $useCountdownTimer, countdownDurationSeconds: $countdownDurationSeconds, markDownbeat: $markDownbeat)';
}


}

/// @nodoc
abstract mixin class _$MetronomeConfigCopyWith<$Res> implements $MetronomeConfigCopyWith<$Res> {
  factory _$MetronomeConfigCopyWith(_MetronomeConfig value, $Res Function(_MetronomeConfig) _then) = __$MetronomeConfigCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? title, double initialBpm, List<CellConfig> cellSequence, double strongBeatVolume, double weakBeatVolume, bool useCountdownTimer, int countdownDurationSeconds, bool markDownbeat
});




}
/// @nodoc
class __$MetronomeConfigCopyWithImpl<$Res>
    implements _$MetronomeConfigCopyWith<$Res> {
  __$MetronomeConfigCopyWithImpl(this._self, this._then);

  final _MetronomeConfig _self;
  final $Res Function(_MetronomeConfig) _then;

/// Create a copy of MetronomeConfig
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? title = freezed,Object? initialBpm = null,Object? cellSequence = null,Object? strongBeatVolume = null,Object? weakBeatVolume = null,Object? useCountdownTimer = null,Object? countdownDurationSeconds = null,Object? markDownbeat = null,}) {
  return _then(_MetronomeConfig(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,title: freezed == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String?,initialBpm: null == initialBpm ? _self.initialBpm : initialBpm // ignore: cast_nullable_to_non_nullable
as double,cellSequence: null == cellSequence ? _self._cellSequence : cellSequence // ignore: cast_nullable_to_non_nullable
as List<CellConfig>,strongBeatVolume: null == strongBeatVolume ? _self.strongBeatVolume : strongBeatVolume // ignore: cast_nullable_to_non_nullable
as double,weakBeatVolume: null == weakBeatVolume ? _self.weakBeatVolume : weakBeatVolume // ignore: cast_nullable_to_non_nullable
as double,useCountdownTimer: null == useCountdownTimer ? _self.useCountdownTimer : useCountdownTimer // ignore: cast_nullable_to_non_nullable
as bool,countdownDurationSeconds: null == countdownDurationSeconds ? _self.countdownDurationSeconds : countdownDurationSeconds // ignore: cast_nullable_to_non_nullable
as int,markDownbeat: null == markDownbeat ? _self.markDownbeat : markDownbeat // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
