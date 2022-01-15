import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruby_theft/colors/colors.dart';
import 'package:ruby_theft/l10n/l10n.dart';
import 'package:ruby_theft/layout/layout.dart';
import 'package:ruby_theft/models/models.dart';
import 'package:ruby_theft/puzzle/puzzle.dart';
import 'package:ruby_theft/theme/widgets/number_of_moves.dart';
import 'package:ruby_theft/theme/widgets/puzzle_button.dart';
import 'package:ruby_theft/theme/widgets/puzzle_tile.dart';
import 'package:ruby_theft/theme/widgets/puzzle_title.dart';

/// {@template simple_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
@visibleForTesting
class SimpleStartSection extends StatelessWidget {
  /// {@macro simple_start_section}
  const SimpleStartSection({
    Key? key,
    required this.state,
    required this.level,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  final int level;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const ResponsiveGap(
          small: 20,
          medium: 83,
          large: 151,
        ),
        const ResponsiveGap(large: 16),
        SimplePuzzleTitle(
          status: state.puzzleStatus,
          level: level,
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        NumberOfMoves(
          numberOfMoves: state.numberOfMoves,
        ),
        const ResponsiveGap(large: 32),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => const SimplePuzzleShuffleButton(),
        ),
      ],
    );
  }
}

/// {@template simple_puzzle_title}
/// Displays the title of the puzzle based on [status].
///
/// Shows the success state when the puzzle is completed,
/// otherwise defaults to the Puzzle Challenge title.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleTitle extends StatelessWidget {
  /// {@macro simple_puzzle_title}
  const SimplePuzzleTitle({
    Key? key,
    required this.status,
    required this.level,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleStatus status;

  /// currents puzzle level to display in header
  final int level;

  @override
  Widget build(BuildContext context) {
    return PuzzleTitle(
      title: status == PuzzleStatus.complete
          ? context.l10n.puzzleCompleted
          : 'Level ' + level.toString(),
    );
  }
}


/// {@template simple_puzzle_board}
/// Display the board of the puzzle in a [size]x[size] layout
/// filled with [tiles]. Each tile is spaced with [spacing].
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleBoard extends StatelessWidget {
  /// {@macro simple_puzzle_board}
  const SimplePuzzleBoard({
    Key? key,
    required this.size,
    required this.tiles,
    required this.goal,
    this.spacing = 8,
  }) : super(key: key);

  /// The size of the board.
  final int size;

  /// The tiles to be displayed on the board.
  final List<Tile> tiles;

  /// The boards goal for the ruby
  final Position goal;

  /// The spacing between each tile from [tiles].
  final double spacing;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(color: Colors.black54, margin: const EdgeInsets.all(2.0),),
        backgroundGrid(context, goal),
        jewels(context, tiles),
      ],
    );
  }

  double _tileAbsolutePosition(int pos, double tileSize) {
    return pos * tileSize + (pos * spacing);
  }

  double _tileHeight(double tileSize, Tile tile) {
    if (tile.currentPositions.length == 0) return tileSize;
    return tileSize;
  }

  double _tileWidth(double tileSize, Tile tile) {
    if (tile.currentPositions.length == 0) return tileSize;
    return tileSize * tile.currentPositions.length + (tile.currentPositions.length-1) * spacing;
  }

  Widget _jewel(BuildContext context, Tile tile) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double tileSize = (constraints.maxWidth - ((size-1)*spacing)) / size;
        double y = _tileAbsolutePosition(tile.currentPositions[0].y, tileSize);
        double x = _tileAbsolutePosition(tile.currentPositions[0].x, tileSize);
        double height = _tileHeight(tileSize, tile);
        double width = _tileWidth(tileSize, tile);
        return Stack(
          children: [
            Positioned(
                top: y,
                left: x,
                height: height,
                width: width,
                child: PuzzleTile(tile: tile, state: const PuzzleState())
            )
          ],
        );
      }
    );
  }

  Widget jewels(BuildContext context, List<Tile> tiles) {
    List<Widget> widgets = [];
    for (var tile in tiles) {
      widgets.add(_jewel(context, tile));
    }
    return Stack(
      children: widgets,
    );
  }

  Widget backgroundGrid(BuildContext context, Position goal) {
    List<Widget> backgroundTiles = [];
    for (int i = 0; i < size * size; i++) {
      int x = i % size;
      int y = i ~/ size;
      if (goal.x == x && goal.y == y) {
        backgroundTiles.add(
            GoalTile(state: const PuzzleState(), position: goal,)
        );
      } else {
        backgroundTiles.add(
            EmptyTile(
              position: Position(
                x: x,
                y: y,
              ),
            )
        );
      }
    }

    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: size,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: backgroundTiles,
    );
  }
}


/// {@template puzzle_shuffle_button}
/// Displays the button to shuffle the puzzle.
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleShuffleButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const SimplePuzzleShuffleButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PuzzleButton(
      textColor: PuzzleColors.primary0,
      backgroundColor: PuzzleColors.primary6,
      onPressed: () => context.read<PuzzleBloc>().add(const PuzzleInitialized(level: 0)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          /*Image.asset(
            'assets/images/shuffle_icon.png',
            width: 17,
            height: 17,
          ),
          const Gap(10),*/
          Text(context.l10n.puzzleRestart),
        ],
      ),
    );
  }
}
