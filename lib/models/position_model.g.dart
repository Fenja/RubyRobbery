// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'position_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Position _$PositionFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['x', 'y'],
  );
  return Position(
    x: json['x'] as int,
    y: json['y'] as int,
  );
}

Map<String, dynamic> _$PositionToJson(Position instance) => <String, dynamic>{
      'x': instance.x,
      'y': instance.y,
    };
