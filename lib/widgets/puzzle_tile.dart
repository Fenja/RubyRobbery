import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:ruby_theft/helper/utils.dart';
import 'package:ruby_theft/models/models.dart';
import 'package:ruby_theft/puzzle/puzzle.dart';

/// {@template simple_puzzle_tile}
/// Displays the puzzle tile associated with [tile] and
/// the font size of [tileFontSize] based on the puzzle [state].
/// {@endtemplate}
@visibleForTesting
class PuzzleTile extends StatelessWidget {

  const PuzzleTile({
    Key? key,
    required this.tile,
    required this.puzzle,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The whole puzzle to allow movement.
  final Puzzle puzzle;

  @override
  Widget build(BuildContext context) {
    switch (tile.type) {
      case (TileType.ruby):
        return ruby();
      case (TileType.diamond):
        return diamond();
      case (TileType.pearl):
        return pearl();
      case (TileType.blocker):
        return blocker();
    }
    return diamond();
  }

  Widget ruby() {
    if (_isMoveable()) {
      return draggableJewel();
    } else {
      return _child();
    }
  }

  Widget diamond() {
    if (_isMoveable()) {
      return draggableJewel();
    } else {
      return _child();
    }
  }

  Widget draggableJewel() {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints contraints) =>
          Draggable<Tile>(
            data: tile,
            child: _child(),
            feedback: _feedback(contraints),
            childWhenDragging: _childWhenDragging(),
            onDragStarted: () => print('drag queen'),
            maxSimultaneousDrags: 1,
      )
    );
  }

  Widget _childWhenDragging() {
    return DecoratedBox(
      key: Key('tile_child_dragging_'+tile.id.toString()),
      decoration: BoxDecoration(
        color: _makeOpaque(_colorForType(tile.type)),
        shape: BoxShape.rectangle,
      )
    );
  }

  Widget _child() {
    return DecoratedBox(
      key: Key('tile_child_'+tile.id.toString()),
      decoration: BoxDecoration(
        color: _colorForType(tile.type),
        shape: BoxShape.rectangle,
      )
    );
  }

  Widget _feedback(BoxConstraints constraints) {
    return SizedBox(
      width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: _child(),
    );
  }

  Color _colorForType(TileType type) {
    switch(type) {
      case TileType.ruby: return Colors.red;
      case TileType.pearl: return Colors.white;
      case TileType.blocker: return Colors.black;
      case TileType.diamond: return Colors.blue;
    }
  }

  _makeOpaque(Color color) {
    return color.withAlpha(100);
  }

  Widget pearl() {
    // TODO shake on tap
    return DecoratedBox(
        key: Key('pearl_'+tile.id.toString()),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        )
    );
  }

  Widget blocker() {
    return DecoratedBox(
        key: Key('blocker_'+tile.id.toString()),
        decoration: const BoxDecoration(
          color: Colors.black,
        )
    );
  }

  bool _isMoveable() {
    return puzzle.isTileMovable(tile);
  }
}

class EmptyTile extends StatelessWidget {
  const EmptyTile({Key? key, required this.position}) : super(key: key);

  final Position position;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Tile>(
      builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
          ){
        return SizedBox(child: Container(color: Colors.black45));
      },
      onAccept: (tile) {
        Position currentPosition = tile.currentPositions.length == 1 ? tile.currentPositions[0] : getDraggedPositionOfTile(tile, position);
        context.read<PuzzleBloc>().add(TileDragged(tile, currentPosition, position));
      },
      /*onLeave: (tile) {
        print('dont go!');
      },*/
    );
  }
}

class GoalTile extends StatelessWidget {
  /// {@macro simple_puzzle_tile}
  const GoalTile({
    Key? key,
    required this.position,
  }) : super(key: key);

  final Position position;

  @override
  Widget build(BuildContext context) {
    return DragTarget<Tile>(
      builder: (
          BuildContext context,
          List<dynamic> accepted,
          List<dynamic> rejected,
          ){
        return SizedBox(
          child: Container(
            //margin: const EdgeInsets.all(15.0),
            padding: const EdgeInsets.all(3.0),
            decoration: BoxDecoration(
              color: Colors.black45,
              border: Border.all(
                color: Colors.orangeAccent,
              ),
            ),
          )
        );
      },
      onAccept: (tile) {
        Position currentPosition = tile.currentPositions.length == 1 ? tile.currentPositions[0] : getDraggedPositionOfTile(tile, position);
        context.read<PuzzleBloc>().add(TileDragged(tile, currentPosition, position));
      },
      onLeave: (tile) {
        print('dont go!');
      },
    );
  }
}
