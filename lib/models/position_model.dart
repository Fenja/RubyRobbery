import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'position_model.g.dart';

/// {@template position}
/// 2-dimensional position model.
///
/// (1, 1) is the top left corner of the board.
/// {@endtemplate}
@JsonSerializable(explicitToJson: true, fieldRename: FieldRename.snake)
class Position extends Equatable implements Comparable<Position> {

  @JsonKey(required: true)
  final int x;
  @JsonKey(required: true)
  final int y;

  const Position({required this.x, required this.y});

  factory Position.fromJson(Map<String,dynamic> json) => _$PositionFromJson(json);
  Map<String,dynamic> toJson() => _$PositionToJson(this);

  @override
  List<Object> get props => [x, y];

  @override
  int compareTo(Position other) {
    if (y < other.y) {
      return -1;
    } else if (y > other.y) {
      return 1;
    } else {
      if (x < other.x) {
        return -1;
      } else if (x > other.x) {
        return 1;
      } else {
        return 0;
      }
    }
  }

  /// Create a copy of this [Position] with updated coordinates.
  Position copyWith({int? xPos, int? yPos}) {
    return Position(
      x: xPos ?? x,
      y: yPos ?? y,
    );
  }
}
