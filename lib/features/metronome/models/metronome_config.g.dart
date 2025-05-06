// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'metronome_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MetronomeConfig _$MetronomeConfigFromJson(Map<String, dynamic> json) =>
    _MetronomeConfig(
      id: json['id'] as String?,
      title: json['title'] as String?,
      initialBpm: (json['initialBpm'] as num?)?.toDouble() ?? 120.0,
      cellSequence:
          (json['cellSequence'] as List<dynamic>)
              .map((e) => CellConfig.fromJson(e as Map<String, dynamic>))
              .toList(),
      strongBeatVolume:
          (json['strongBeatVolume'] as num?)?.toDouble() ??
          MetronomeVolume.strongBeatVolume,
      weakBeatVolume:
          (json['weakBeatVolume'] as num?)?.toDouble() ??
          MetronomeVolume.weakBeatVolume,
      useCountdownTimer: json['useCountdownTimer'] as bool? ?? false,
      countdownDurationSeconds:
          (json['countdownDurationSeconds'] as num?)?.toInt() ?? 300,
      markDownbeat: json['markDownbeat'] as bool? ?? true,
    );

Map<String, dynamic> _$MetronomeConfigToJson(_MetronomeConfig instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'initialBpm': instance.initialBpm,
      'cellSequence': instance.cellSequence,
      'strongBeatVolume': instance.strongBeatVolume,
      'weakBeatVolume': instance.weakBeatVolume,
      'useCountdownTimer': instance.useCountdownTimer,
      'countdownDurationSeconds': instance.countdownDurationSeconds,
      'markDownbeat': instance.markDownbeat,
    };
