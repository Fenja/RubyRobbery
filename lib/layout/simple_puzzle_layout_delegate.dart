import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruby_theft/colors/colors.dart';
import 'package:ruby_theft/l10n/l10n.dart';
import 'package:ruby_theft/layout/layout.dart';
import 'package:ruby_theft/models/direction.dart';
import 'package:ruby_theft/models/models.dart';
import 'package:ruby_theft/puzzle/puzzle.dart';
import 'package:ruby_theft/theme/widgets/number_of_moves.dart';
import 'package:ruby_theft/theme/widgets/puzzle_button.dart';
import 'package:ruby_theft/theme/widgets/puzzle_title.dart';
import 'package:ruby_theft/typography/typography.dart';

/// {@template simple_puzzle_layout_delegate}
/// A delegate for computing the layout of the puzzle UI
/// that uses a [SimpleTheme].
/// {@endtemplate}
class SimplePuzzleLayoutDelegate {

  Widget backgroundBuilder(PuzzleState state) {
    return Positioned(
      right: 0,
      bottom: 0,
      child: ResponsiveLayoutBuilder(
        small: (_, __) => SizedBox(
          width: 184,
          height: 118,
          child: Image.asset(
            'assets/images/bg_pattern.png',
            key: const Key('bg_pattern_small'),
          ),
        ),
        medium: (_, __) => SizedBox(
          width: 380.44,
          height: 214,
          child: Image.asset(
            'assets/images/bg_pattern.png',
            key: const Key('bg_pattern_medium'),
          ),
        ),
        large: (_, __) => Padding(
          padding: const EdgeInsets.only(bottom: 53),
          child: SizedBox(
            width: 568.99,
            height: 320,
            child: Image.asset(
              'assets/images/bg_pattern.png',
              key: const Key('bg_pattern_large'),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget tileBuilder(Tile tile, PuzzleState state) {
    return SimplePuzzleTile(
        key: Key('simple_puzzle_tile_${tile.type}_small'),
        tile: tile,
        state: state,
      );
  }

  @override
  Widget whitespaceTileBuilder() {
    return const SizedBox();
  }

  @override
  List<Object?> get props => [];
}

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
        backgroundGrid(context, size),
        jewels(context, size, tiles),
        boardGoal(context, size, goal),
      ],
    );
  }

  Widget jewels(BuildContext context, int dimension, List<Tile> tiles) {
    List<Widget> widgets = List.filled(dimension * dimension, const SizedBox());
    for (var tile in tiles) {
      var replaceTileIndex = tile.currentPosition.x + tile.currentPosition.y * size;
      widgets[replaceTileIndex] = SimplePuzzleTile(tile: tile, state: const PuzzleState());
    }

    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: size,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: widgets,
    );
  }

  Widget backgroundGrid(BuildContext context, int dimension) {
    List<Widget> backgroundTiles = List.filled(dimension * dimension, SizedBox(child: Container(color: Colors.black54)));

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

  Widget boardGoal(BuildContext context, int dimension, Position position) {
    List<Widget> widgets = List.filled(dimension * dimension, const SizedBox());
    var replaceTileIndex = position.x + position.y * size;
    widgets[replaceTileIndex] = GoalTile(state: const PuzzleState());

    return GridView.count(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: size,
      mainAxisSpacing: spacing,
      crossAxisSpacing: spacing,
      children: widgets,
    );
  }
}


/// {@template simple_puzzle_tile}
/// Displays the puzzle tile associated with [tile] and
/// the font size of [tileFontSize] based on the puzzle [state].
/// {@endtemplate}
@visibleForTesting
class SimplePuzzleTile extends StatelessWidget {
  /// {@macro simple_puzzle_tile}
  const SimplePuzzleTile({
    Key? key,
    required this.tile,
    required this.state,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(20),
          ),
        ),
        backgroundColor: _colorForType(tile.type),
      ),
      // TODO onDragged event or gesture listener
      onPressed: state.puzzleStatus == PuzzleStatus.incomplete
          ? () => context.read<PuzzleBloc>().add(TileDragged(tile,Direction.north))
          : null,
      child: Text(tile.id.toString(),
          style: const TextStyle(color: Colors.black)),
    );
  }

  _colorForType(TileType type) {
    switch(type) {
      case TileType.ruby: return Colors.red;
      case TileType.pearl: return Colors.white;
      case TileType.blocker: return Colors.black;
      case TileType.diamond: return Colors.blue;
    }
  }
}

class GoalTile extends StatelessWidget {
  /// {@macro simple_puzzle_tile}
  const GoalTile({
    Key? key,
    required this.state,
  }) : super(key: key);

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(15.0),
      padding: const EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.orangeAccent,
        ),
      ),
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
