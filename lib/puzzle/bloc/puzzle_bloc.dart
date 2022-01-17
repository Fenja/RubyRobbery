// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ruby_theft/models/direction.dart';
import 'package:ruby_theft/models/models.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this.level) : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileDragged>(_onTileDragged);
  }

  final int level;

  void _onPuzzleInitialized(
      PuzzleInitialized event,
      Emitter<PuzzleState> emit,
      ) {
    emit(
      const PuzzleState().copyWith(
        puzzle: loadPuzzleForLevel(),
      ),
    );
  }

  Puzzle loadPuzzleForLevel() {
    return Puzzle(level,1,0,goal: const Position(x: 2, y: 2),dimension: 3,
        tiles: const [
          Tile(id: 'r', type: TileType.ruby, currentPositions: [Position(x: 0, y: 0)]),
          Tile(id: 'd1', type: TileType.pearl, currentPositions: [Position(x: 1, y: 1)]),
          Tile(id: 'd2', type: TileType.diamond, currentPositions: [Position(x: 1, y: 0),Position(x: 2, y: 0)]),
          Tile(id: 'b1', type: TileType.blocker, currentPositions: [Position(x: 1, y: 2)]),
        ]);
  }

  void _onTileDragged(
      TileDragged event,
      Emitter<PuzzleState> emit,
      ) {
    final tile = event.tile;
    final newPosition = event.position;

    // check if move allowed
    if (
      state.puzzleStatus == PuzzleStatus.incomplete &&
      state.puzzle.isTileMovableTo(tile, newPosition)
    ) {

      if (tile.type == TileType.ruby && newPosition == state.puzzle.goal) {
        // puzzle solved!
        emit(
          state.copyWith(
            puzzle: state.puzzle.moveTile(tile, newPosition),
            puzzleStatus: PuzzleStatus.complete,
            tileMovementStatus: TileMovementStatus.moved,
            numberOfMoves: state.numberOfMoves + 1,
            lastTappedTile: tile,
          ),
        );

      } else {
        // move tile
        emit(
          state.copyWith(
            puzzle: state.puzzle.moveTile(tile, newPosition),
            tileMovementStatus: TileMovementStatus.moved,
            numberOfMoves: state.numberOfMoves + 1,
            lastTappedTile: tile,
          ),
        );
      }
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }
  }
}
