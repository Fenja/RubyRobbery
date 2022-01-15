import 'package:equatable/equatable.dart';
import 'package:ruby_theft/models/models.dart';

// A 3x3 puzzle board visualization:
//
//   ┌─────1───────2───────3────► x
//   │  ┌─────┐ ┌─────┐ ┌─────┐
//   1  │  1  │ │  2  │ │  3  │
//   │  └─────┘ └─────┘ └─────┘
//   │  ┌─────┐ ┌─────┐ ┌─────┐
//   2  │  4  │ │  5  │ │  6  │
//   │  └─────┘ └─────┘ └─────┘
//   │  ┌─────┐ ┌─────┐
//   3  │  7  │ │  8  │
//   │  └─────┘ └─────┘
//   ▼
//   y
//
// This puzzle is in its completed state (i.e. the tiles are arranged in
// ascending order by value from top to bottom, left to right).
//
// Each tile has a value (1-8 on example above), and a correct and current
// position.
//
// The correct position is where the tile should be in the completed
// puzzle. As seen from example above, tile 2's correct position is (2, 1).
// The current position is where the tile is currently located on the board.

/// {@template puzzle}
/// Model for a puzzle.
/// {@endtemplate}
class Puzzle extends Equatable {
  /// {@macro puzzle}
  const Puzzle(this.level, this.rubyReward, this.rubyRepeat, {required this.goal, required this.dimension, required this.tiles});

  /// List of [Tile]s representing the puzzle's tiles: ruby, blocker, diamonds and pearls.
  final List<Tile> tiles;

  /// position of goal for the ruby tile.
  final Position goal;

  /// boards dimension: 3 -> 3x3 board
  final int dimension;

  /// level as name to load from assets
  final int level;


  /// reward to complete level first time
  final int rubyReward;

  /// reward to complete level an additional time
  final int rubyRepeat;

  /// Get the whitespaces on the board.
  Tile getWhitespacePositions() {
    return tiles.singleWhere((tile) => tile.isWhitespace);
  }

  /// Determines if the puzzle is completed.
  bool isComplete() {
    return tiles.singleWhere((tile) => tile.type == TileType.ruby).currentPositions[0] == goal;
  }

  /// Determines if the tapped tile can move in the direction of the whitespace
  /// tile.
  bool isTileMovableTo(Tile tile, Position position) {
    if (tile.type == TileType.blocker || tile.type == TileType.pearl) return false;
    // TODO check whether every position in direction is either of same tile id or empty
    return true;
  }

  bool isTileMovable(Tile tile) {
    if (tile.type == TileType.blocker || tile.type == TileType.pearl) return false;
    // TODO check whether movement is possible
    return true;
  }

  Puzzle moveTile(Tile tile, Position position) {
    final index = tiles.indexOf(tile);
    List<Tile> newTiles = [];
    newTiles.addAll(tiles);
    newTiles[index] = tile.copyWith(currentPositions: [position]);
    return Puzzle(level, rubyReward, rubyRepeat, goal: goal, dimension: dimension, tiles: newTiles);
  }

  @override
  List<Object?> get props => [goal, dimension, tiles];

}
