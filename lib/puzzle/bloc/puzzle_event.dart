// ignore_for_file: public_member_api_docs

part of 'puzzle_bloc.dart';

abstract class PuzzleEvent extends Equatable {
  const PuzzleEvent();

  @override
  List<Object> get props => [];
}

class PuzzleInitialized extends PuzzleEvent {
  const PuzzleInitialized({required this.level});

  final int level;

  @override
  List<Object> get props => [level];
}

class TileDragged extends PuzzleEvent {
  const TileDragged(this.tile, this.position);

  final Tile tile;
  final Position position;

  @override
  List<Object> get props => [tile, position];
}

class BoxTipped extends PuzzleEvent {
  const BoxTipped(this.direction);

  final Direction direction;

  @override
  List<Object> get props => [direction];
}
