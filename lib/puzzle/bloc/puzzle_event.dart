// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

class PuzzleInitialized extends PuzzleEvent {
  const PuzzleInitialized();

  @override
  List<Object> get props => [];
}

class TileDragged extends PuzzleEvent {
  const TileDragged(this.tile, this.currentPosition, this.newPosition);

  final Tile tile;
  final Position currentPosition;
  final Position newPosition;

  @override
  List<Object> get props => [tile, currentPosition, newPosition];
}

class BoxTipped extends PuzzleEvent {
  const BoxTipped(this.direction);

  final Direction direction;

  @override
  List<Object> get props => [direction];
}
