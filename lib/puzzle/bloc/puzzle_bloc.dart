// ignore_for_file: public_member_api_docs

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:ruby_theft/models/direction.dart';
import 'package:ruby_theft/models/levels.dart';
import 'package:ruby_theft/models/models.dart';

part 'puzzle_event.dart';
part 'puzzle_state.dart';

class PuzzleBloc extends Bloc<PuzzleEvent, PuzzleState> {
  PuzzleBloc(this.levelId) : super(const PuzzleState()) {
    on<PuzzleInitialized>(_onPuzzleInitialized);
    on<TileDragged>(_onTileDragged);
  }

  final String levelId;
  Levels levels = Levels();

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
    Level level = levels.getLevelById(levelId);
    return Puzzle(
        levelId,
        goal:level.goal,
        dimension: level.dimension,
        tiles: level.tiles);
  }

  void _onTileDragged(
      TileDragged event,
      Emitter<PuzzleState> emit,
      ) {
    final tile = event.tile;
    final currentPosition = event.currentPosition;
    final newPosition = event.newPosition;

    // check if move allowed
    if (
      state.puzzleStatus == PuzzleStatus.incomplete &&
      state.puzzle.isTileMovableTo(tile, currentPosition, newPosition)
    ) {

      if (tile.type == TileType.ruby && newPosition == state.puzzle.goal) {
        // puzzle solved!
        emit(
          state.copyWith(
            puzzle: state.puzzle.moveTile(tile, currentPosition, newPosition),
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
            puzzle: state.puzzle.moveTile(tile, currentPosition, newPosition),
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
