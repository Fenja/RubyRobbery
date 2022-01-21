import 'package:equatable/equatable.dart';
import 'package:ruby_theft/helper/utils.dart';
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
  const Puzzle(this.level, {required this.goal, required this.dimension, required this.tiles});

  /// List of [Tile]s representing the puzzle's tiles: ruby, blocker, diamonds and pearls.
  final List<Tile> tiles;

  /// position of goal for the ruby tile.
  final Position goal;

  /// boards dimension: 3 -> 3x3 board
  final int dimension;

  /// level id
  final String level;

  /// Determines if the puzzle is completed.
  bool isComplete() {
    return tiles.singleWhere((tile) => tile.type == TileType.ruby).currentPositions[0] == goal;
  }

  /// Determines if the tapped tile can move in the direction of the whitespace
  /// tile.
  bool isTileMovableTo(Tile tile, Position currentPosition, Position newPosition) {
    if (tile.type == TileType.blocker || tile.type == TileType.pearl) return false;
    if (isOutOfScopeOrFull(newPosition)) return false;

    if (tile.currentPositions.length == 1) {
      return isAdjacent(currentPosition, newPosition);

    } else {
      // draggedTilePosition will be dragged to position
      Position adjacentPosition = getDraggedPositionOfTile(tile, newPosition);

      // determine direction
      if (adjacentPosition.x == newPosition.x) {
        if (adjacentPosition.y > newPosition.y) {
          // move up
          for (var pos in tile.currentPositions) {
            if (isOutOfScopeOrFull(pos.copyWith(yPos: pos.y-1),exceptId: tile.id)) return false;
          }
          return true;
        } else {
          // move down
          for (var pos in tile.currentPositions) {
            if (isOutOfScopeOrFull(pos.copyWith(yPos: pos.y+1),exceptId: tile.id)) return false;
          }
          return true;
        }
      } else if (adjacentPosition.y == newPosition.y) {
        if (adjacentPosition.x > newPosition.x) {
          // move left
          for (var pos in tile.currentPositions) {
            if (isOutOfScopeOrFull(pos.copyWith(xPos: pos.x-1),exceptId: tile.id)) return false;
          }
          return true;
        } else {
          // move right
          for (var pos in tile.currentPositions) {
            if (isOutOfScopeOrFull(pos.copyWith(xPos: pos.x+1),exceptId: tile.id)) return false;
          }
          return true;
        }
      } else {
        return false;
      }
    }
  }

  /// Determines if given [Tile] is moveable into any of the four directions
  bool isTileMovable(Tile tile) {
    if (tile.type == TileType.blocker || tile.type == TileType.pearl) return false;

    // for single tile: any adjacent position is empty
    if (tile.currentPositions.length == 1) {
      Position tilePosition = tile.currentPositions[0];
      bool topBlocked = isOutOfScopeOrFull(tilePosition.copyWith(yPos: tilePosition.y -1));
      bool bottomBlocked = isOutOfScopeOrFull(tilePosition.copyWith(yPos: tilePosition.y +1));
      bool leftBlocked = isOutOfScopeOrFull(tilePosition.copyWith(xPos: tilePosition.x -1));
      bool rightBlocked = isOutOfScopeOrFull(tilePosition.copyWith(xPos: tilePosition.x +1));
      bool isBlocked = topBlocked && bottomBlocked && leftBlocked && rightBlocked;
      return !isBlocked;

    // for multi tiles, check if a direction for all tiles is possible
    } else {
      String tileId = tile.id;
      bool topBlocked = false;
      bool bottomBlocked = false;
      bool leftBlocked = false;
      bool rightBlocked = false;

      for (var position in tile.currentPositions) {
        topBlocked = topBlocked || isOutOfScopeOrFull(position.copyWith(yPos: position.y -1), exceptId: tileId);
        bottomBlocked = bottomBlocked || isOutOfScopeOrFull(position.copyWith(yPos: position.y +1), exceptId: tileId);
        leftBlocked = leftBlocked || isOutOfScopeOrFull(position.copyWith(xPos: position.x -1), exceptId: tileId);
        rightBlocked = rightBlocked || isOutOfScopeOrFull(position.copyWith(xPos: position.x +1), exceptId: tileId);
      }
      return !(topBlocked && bottomBlocked && leftBlocked && rightBlocked);
    }
  }

  /// Determines if the [Position] given is blocked or out of scope
  /// except for tiles with the id [exceptId] to ask for multitiles
  /// returns true, if position is out of scope or blocked
  bool isOutOfScopeOrFull(Position pos, {String? exceptId}) {
    if (pos.x < 0 || pos.y < 0 || pos.x > dimension-1 || pos.y > dimension-1) return true;
    for (var tile in tiles) {
      if (tile.currentPositions.contains(pos) && (exceptId == null || tile.id != exceptId)) {
        return true;
      }
    }
    return false;
  }

  /// Updates the [Tile] by changing the current Position to the given [Position]
  Puzzle moveTile(Tile tile, Position currentPosition, Position newPosition) {

    List<Position> newPositions = [];
    if (tile.currentPositions.length == 1) {
      newPositions = [newPosition];
    } else {
      // determine direction
      if (currentPosition.x == newPosition.x) {
        if (currentPosition.y > newPosition.y) {
          // move up
          for (var pos in tile.currentPositions) {
            newPositions.add(pos.copyWith(yPos: pos.y-1));
          }
        } else {
          // move down
          for (var pos in tile.currentPositions) {
            newPositions.add(pos.copyWith(yPos: pos.y+1));
          }
        }
      } else if (currentPosition.y == newPosition.y) {
        if (currentPosition.x > newPosition.x) {
          // move left
          for (var pos in tile.currentPositions) {
            newPositions.add(pos.copyWith(xPos: pos.x-1));
          }
        } else {
          // move right
          for (var pos in tile.currentPositions) {
            newPositions.add(pos.copyWith(xPos: pos.x+1));
          }
        }
      }
    }

    final index = tiles.indexOf(tile);
    List<Tile> newTiles = [];
    newTiles.addAll(tiles);
    newTiles[index] = tile.copyWith(currentPositions: newPositions);
    return Puzzle(level, goal: goal, dimension: dimension, tiles: newTiles);
  }

  @override
  List<Object?> get props => [goal, dimension, tiles];

}
