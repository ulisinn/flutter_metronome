// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cell_config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CellConfig _$CellConfigFromJson(Map<String, dynamic> json) => _CellConfig(
  pulses: (json['pulses'] as num).toInt(),
  isActive: json['isActive'] as bool? ?? true,
);

Map<String, dynamic> _$CellConfigToJson(_CellConfig instance) =>
    <String, dynamic>{'pulses': instance.pulses, 'isActive': instance.isActive};
