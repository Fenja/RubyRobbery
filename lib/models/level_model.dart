import 'package:ruby_theft/models/models.dart';
import 'package:json_annotation/json_annotation.dart';

part 'level_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Level {

  @JsonKey(required: true)
  final String id;
  @JsonKey(required: true)
  final String nameKey;
  @JsonKey(required: true)
  final int dimension;
  @JsonKey(required: true)
  final Position goal;
  @JsonKey(required: true)
  final List<Tile> tiles;
  @JsonKey(required: true)
  final bool hasPearls;

  @JsonKey(required: true)
  final bool unlocked;
  @JsonKey(required: true)
  final int difficulty;
  @JsonKey(required: true)
  final int rubyReward; // reward for first solve
  @JsonKey(required: true)
  final int rubyRepeat; // reward for following solves
  @JsonKey(required: true)
  final int rubyCost; // cost to unlock level

  Level({required this.id, required this.nameKey, required this.dimension, required this.goal, required this.tiles, required this.hasPearls,
    required this.unlocked, required this.difficulty, required this.rubyReward, required this.rubyRepeat, required this.rubyCost});

  factory Level.fromJson(Map<String,dynamic> json) => _$LevelFromJson(json);
  Map<String,dynamic> toJson() => _$LevelToJson(this);
}
