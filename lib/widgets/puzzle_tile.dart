import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:ruby_robbery/helper/sound_module.dart';
import 'package:ruby_robbery/helper/utils.dart';
import 'package:ruby_robbery/models/models.dart';
import 'package:ruby_robbery/puzzle/puzzle.dart';

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
    Widget ruby = Image(
        key: Key('ruby_'+tile.id.toString()),
        image: const AssetImage('assets/images/ruby.png')
    );
    if (_isMoveable()) {
      return draggableJewel(ruby);
    } else {
      return ruby;
    }
  }

  Widget diamond() {
    Widget diamond = FittedBox(
      child: Image(
          key: Key('diamond_'+tile.id.toString()),
          image: _getImageForId(tile.id)
      ),
      fit: BoxFit.fill,
    );
    if (_isMoveable()) {
      return draggableJewel(diamond);
    } else {
      return diamond;
    }
  }

  AssetImage _getImageForId(String id) {
    int nr = int.parse(id.replaceFirst('d', ''));
    const int differentDiamonds = 6;
    nr = nr % differentDiamonds;
    String path = '';
    switch(nr) {
      case 1: path = 'assets/images/diamond1.png'; break;
      case 2: path = 'assets/images/diamond2.png'; break;
      case 3: path = 'assets/images/diamond3.png'; break;
      case 4: path = 'assets/images/diamond4.png'; break;
      case 5: path = 'assets/images/diamond5.png'; break;
      case 6: path = 'assets/images/diamond6.png'; break;
      default: path = 'assets/images/diamond1.png';
    }
    return AssetImage(path);
  }

  Widget draggableJewel(Widget jewel) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints contraints) =>
          Draggable<Tile>(
            data: tile,
            child: jewel,
            feedback: _feedback(contraints, jewel),
            childWhenDragging: _childWhenDragging(jewel),
            //onDragStarted: () => print('drag queen'),
            maxSimultaneousDrags: 1,
      )
    );
  }

  Widget _childWhenDragging(Widget jewel) {
    return Opacity(
      opacity: 0.4,
      child: jewel,
    );
  }

  Widget _feedback(BoxConstraints constraints, Widget jewel) {
    return SizedBox(
      width: constraints.maxWidth,
        height: constraints.maxHeight,
        child: jewel,
    );
  }

  Widget pearl() {
    // TODO shake on tap
    return Image(
      key: Key('pearl_'+tile.id.toString()),
      image: const AssetImage('assets/images/pearl.png')
    );
  }

  Widget blocker() {
    return Image(
        key: Key('blocker_'+tile.id.toString()),
        image: const AssetImage('assets/images/blocker.png')
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
        playSound();
        context.read<PuzzleBloc>().add(TileDragged(tile, currentPosition, position));
      },
      /*onLeave: (tile) {
        print('dont go!');
      },*/
    );
  }

  playSound() {
    SoundModule soundModule = SoundModule();
    soundModule.playSound(soundModule.TILE_MOVED_SOUND);
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
        return const Image(
            key: Key('goal_tile'),
            image: AssetImage('assets/images/goal.png')
        );
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
