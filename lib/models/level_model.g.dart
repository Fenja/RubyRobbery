// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'level_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Level _$LevelFromJson(Map<String, dynamic> json) {
  $checkKeys(
    json,
    requiredKeys: const [
      'id',
      'name_key',
      'dimension',
      'goal',
      'tiles',
      'has_pearls',
      'has_opals',
      'unlocked',
      'difficulty',
      'ruby_reward',
      'ruby_repeat',
      'ruby_cost'
    ],
  );
  return Level(
    id: json['id'] as String,
    nameKey: json['name_key'] as String,
    dimension: json['dimension'] as int,
    goal: Position.fromJson(json['goal'] as Map<String, dynamic>),
    tiles: (json['tiles'] as List<dynamic>)
        .map((e) => Tile.fromJson(e as Map<String, dynamic>))
        .toList(),
    hasPearls: json['has_pearls'] as bool,
    hasOpals: json['has_opals'] as bool,
    unlocked: json['unlocked'] as bool,
    difficulty: json['difficulty'] as int,
    rubyReward: json['ruby_reward'] as int,
    rubyRepeat: json['ruby_repeat'] as int,
    rubyCost: json['ruby_cost'] as int,
  );
}

Map<String, dynamic> _$LevelToJson(Level instance) => <String, dynamic>{
      'id': instance.id,
      'name_key': instance.nameKey,
      'dimension': instance.dimension,
      'goal': instance.goal.toJson(),
      'tiles': instance.tiles.map((e) => e.toJson()).toList(),
      'has_pearls': instance.hasPearls,
      'unlocked': instance.unlocked,
      'difficulty': instance.difficulty,
      'ruby_reward': instance.rubyReward,
      'ruby_repeat': instance.rubyRepeat,
      'ruby_cost': instance.rubyCost,
    };
