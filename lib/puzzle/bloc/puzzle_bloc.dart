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
    final puzzle = Puzzle(level,1,0,goal: Position(x: 2, y: 2),dimension: 3,tiles: []);
    emit(
      PuzzleState(
        puzzle: puzzle,
      ),
    );
  }

  void _onTileDragged(
      TileDragged event,
      // Direction direction, //TODO
      Emitter<PuzzleState> emit,
      ) {
    final tappedTile = event.tile;
    /*if (state.puzzleStatus == PuzzleStatus.incomplete) {
      if (state.puzzle.isTileMovable(tappedTile, direction)) {
        //final mutablePuzzle = Puzzle(tiles: [...state.puzzle.tiles]);
        //final puzzle = mutablePuzzle.moveTiles(tappedTile, []);
        /*if (!puzzle.isComplete()) {
          emit(
            state.copyWith(
              puzzle: puzzle,
              puzzleStatus: PuzzleStatus.complete,
              tileMovementStatus: TileMovementStatus.moved,
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );
        } else*/ {
          emit(
            state.copyWith(
              tileMovementStatus: TileMovementStatus.moved,
              numberOfMoves: state.numberOfMoves + 1,
              lastTappedTile: tappedTile,
            ),
          );
        }
      } else {
        emit(
          state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
        );
      }
    } else {
      emit(
        state.copyWith(tileMovementStatus: TileMovementStatus.cannotBeMoved),
      );
    }*/
  }
}
