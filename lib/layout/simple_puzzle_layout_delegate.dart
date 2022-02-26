import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:ruby_robbery/l10n/l10n.dart';
import 'package:ruby_robbery/layout/layout.dart';
import 'package:ruby_robbery/models/models.dart';
import 'package:ruby_robbery/puzzle/puzzle.dart';
import 'package:ruby_robbery/widgets/widgets.dart';

/// {@template simple_start_section}
/// Displays the start section of the puzzle based on [state].
/// {@endtemplate}
@visibleForTesting
class StartSection extends StatelessWidget {
  /// {@macro simple_start_section}
  const StartSection({
    Key? key,
    required this.state,
    required this.levelId,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  /// level id
  final String levelId;

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
        PuzzleTitle(
          title: state.puzzleStatus == PuzzleStatus.complete
              ? context.l10n.puzzleCompleted
              : '',
        ),
        const ResponsiveGap(
          small: 12,
          medium: 16,
          large: 32,
        ),
        /*NumberOfMoves(
          numberOfMoves: state.numberOfMoves,
        ),*/
        const ResponsiveGap(large: 32),
        ResponsiveLayoutBuilder(
          small: (_, __) => const SizedBox(),
          medium: (_, __) => const SizedBox(),
          large: (_, __) => PuzzleResetButton(state: state),
        ),
      ],
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
  SimplePuzzleBoard({
    Key? key,
    required this.puzzle,
    this.spacing = 8,
  }) : super(key: key) {
    size = puzzle.dimension;
    tiles = puzzle.tiles;
    goal = puzzle.goal;
  }

  /// The size of the board.
  late int size;

  /// The tiles to be displayed on the board.
  late List<Tile> tiles;

  /// The boards goal for the ruby
  late Position goal;

  /// The puzzle to display
  final Puzzle puzzle;

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
    if (tile.currentPositions.isEmpty) return tileSize;
    int y = tile.currentPositions[0].y;
    int maxY = tile.currentPositions[tile.currentPositions.length-1].y;
    int height = maxY - y + 1;
    return tileSize * height + (height -1) * spacing;
  }

  double _tileWidth(double tileSize, Tile tile) {
    if (tile.currentPositions.isEmpty) return tileSize;
    int x = tile.currentPositions[0].x;
    int maxX = tile.currentPositions[tile.currentPositions.length-1].x;
    int width = maxX - x + 1;
    return tileSize * width + (width -1) * spacing;
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
                child: PuzzleTile(tile: tile, puzzle: puzzle)
            ),
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
    //AudioPlayer audioPlayer = AudioPlayer(mode: PlayerMode.LOW_LATENCY, isLocal: true);

    List<Widget> backgroundTiles = [];
    for (int i = 0; i < size * size; i++) {
      int x = i % size;
      int y = i ~/ size;
      if (goal.x == x && goal.y == y) {
        backgroundTiles.add(
            GoalTile(position: goal/*, audioPlayer: audioPlayer*/)
        );
      } else {
        backgroundTiles.add(
            EmptyTile(
              position: Position(
                x: x,
                y: y,
              ),
              //audioPlayer: audioPlayer,
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
class PuzzleResetButton extends StatelessWidget {
  /// {@macro puzzle_shuffle_button}
  const PuzzleResetButton({Key? key, required this.state}) : super(key: key);

  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    if (state.puzzleStatus == PuzzleStatus.complete || state.numberOfMoves <= 0) return const SizedBox();

    return RubyButton(
      onPressed: () => context.read<PuzzleBloc>().add(const PuzzleInitialized()),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(context.l10n.puzzleRestart),
        ],
      ),
    );
  }
}
