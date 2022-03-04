// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tile _$TileFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const ['id', 'type', 'current_positions'],
  );
  return Tile(
    id: json['id'] as String,
    type: $enumDecode(_$TileTypeEnumMap, json['type']),
    currentPositions: (json['current_positions'] as List<dynamic>)
        .map((e) => Position.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$TileToJson(Tile instance) => <String, dynamic>{
      'id': instance.id,
      'type': _$TileTypeEnumMap[instance.type],
      'current_positions':
          instance.currentPositions.map((e) => e.toJson()).toList(),
    };

const _$TileTypeEnumMap = {
  TileType.ruby: 'ruby',
  TileType.blocker: 'blocker',
  TileType.diamond: 'diamond',
  TileType.opal: 'opal',
  TileType.pearl: 'pearl',
};
