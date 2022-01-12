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
    required this.currentPosition,
    this.isWhitespace = false,
  });

  /// id of [Tile] to differ the puzzles tiles
  final String id;

  /// Value representing the type of [Tile].
  final TileType type;

  /// The current 2D [Position] of the [Tile].
  final Position currentPosition;

  /// Denotes if the [Tile] is the whitespace tile or not.
  final bool isWhitespace;

  /// Create a copy of this [Tile] with updated current position.
  Tile copyWith({required Position currentPosition}) {
    return Tile(
      id: '',
      type: type,
      currentPosition: currentPosition,
      isWhitespace: isWhitespace,
    );
  }

  @override
  List<Object> get props => [
    type,
    currentPosition,
    isWhitespace,
  ];
}

enum TileType {
  ruby,
  blocker,
  diamond,
  pearl,
}
