import 'package:equatable/equatable.dart';
import 'package:ruby_theft/models/models.dart';

/// {@template tile}
/// Model for a puzzle tile.
/// {@endtemplate}
class Tile extends Equatable {
  /// {@macro tile}
  const Tile({
    required this.id,
    required this.type,
    required this.currentPositions,
    this.isWhitespace = false,
  });

  /// id of [Tile] to differ the puzzles tiles
  final String id;

  /// Value representing the type of [Tile].
  final TileType type;

  /// The current 2D [Position] of the [Tile].
  final List<Position> currentPositions;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required List<Position> currentPositions}) {
    return Tile(
      id: '',
      type: type,
      currentPositions: currentPositions,
      isWhitespace: isWhitespace,
    );
  }

  @override
  List<Object> get props => [
    type,
    currentPositions,
    isWhitespace,
  ];
}

enum TileType {
  ruby,
  blocker,
  diamond,
  pearl,
}
