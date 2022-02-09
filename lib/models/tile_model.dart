import 'package:equatable/equatable.dart';
import 'package:ruby_robbery/models/models.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ruby_robbery/models/position_model.dart';

part 'tile_model.g.dart';

@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Tile extends Equatable {

  /// id of [Tile] to differ the puzzles tiles
  @JsonKey(required: true)
  final String id;

  /// Value representing the type of [Tile].
  @JsonKey(required: true)
  final TileType type;

  /// The current 2D [Position] of the [Tile].
  @JsonKey(required: true)
  final List<Position> currentPositions;

  const Tile({required this.id, required this.type, required this.currentPositions});

  factory Tile.fromJson(Map<String,dynamic> json) => _$TileFromJson(json);
  Map<String,dynamic> toJson() => _$TileToJson(this);

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required List<Position> currentPositions}) {
    return Tile(
      id: id,
      type: type,
      currentPositions: currentPositions,
    );
  }

  @override
  List<Object> get props => [
    id,
    type,
    currentPositions,
  ];
}

enum TileType {
  @JsonValue('ruby')
  ruby,
  @JsonValue('blocker')
  blocker,
  @JsonValue('diamond')
  diamond,
  @JsonValue('pearls')
  pearl,
}
