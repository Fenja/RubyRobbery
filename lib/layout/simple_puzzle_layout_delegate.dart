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
  /// {@macro simple_puzzle_layout_delegate}
  const SimplePuzzleLayoutDelegate();

  @override


  @override
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
    return ResponsiveLayoutBuilder(
      small: (_, __) => SimplePuzzleTile(
        key: Key('simple_puzzle_tile_${tile.type}_small'),
        tile: tile,
        tileFontSize: _TileFontSize.small,
        state: state,
      ),
      medium: (_, __) => SimplePuzzleTile(
        key: Key('simple_puzzle_tile_${tile.type}_medium'),
        tile: tile,
        tileFontSize: _TileFontSize.medium,
        state: state,
      ),
      large: (_, __) => SimplePuzzleTile(
        key: Key('simple_puzzle_tile_${tile.type}_large'),
        tile: tile,
        tileFontSize: _TileFontSize.large,
        state: state,
      ),
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
    this.spacing = 8,
  }) : super(key: key);

  /// The size of the board.
  final int size;

  /// The tiles to be displayed on the board.
  final List<Widget> tiles;

  /// The spacing between each tile from [tiles].
  final double spacing;

  @override
  Widget build(BuildContext context) {

    const dummyTiles = [
      SimplePuzzleTile(tile: Tile(id: 'a', type: TileType.blocker,
          currentPositions: [Position(x: 0, y: 0)]),
          tileFontSize: 20,
        state: PuzzleState()),
      SimplePuzzleTile(tile: Tile(id: 'b', type: TileType.diamond,
          currentPositions: [Position(x: 0, y: 1)]),
          tileFontSize: 20,
        state: PuzzleState()),
      SimplePuzzleTile(tile: Tile(id: 'c', type: TileType.diamond,
          currentPositions: [Position(x: 0, y: 2)]),
          tileFontSize: 20,
        state: PuzzleState()),
      SimplePuzzleTile(tile: Tile(id: 'd', type: TileType.ruby,
          currentPositions: [Position(x: 1, y: 0)]),
          tileFontSize: 20,
        state: PuzzleState()),
      SimplePuzzleTile(tile: Tile(id: 'e', type: TileType.pearl,
          currentPositions: [Position(x: 1, y: 1)]),
          tileFontSize: 20,
        state: PuzzleState()),
      SimplePuzzleTile(tile: Tile(id: 'f', type: TileType.pearl,
          currentPositions: [Position(x: 1, y: 2)]),
          tileFontSize: 20,
        state: PuzzleState()),
    ];
    return Stack(
      children: [
        Container(color: Colors.black45, margin: const EdgeInsets.all(2.0),),
        backgroundGrid(context, 3),
        GridView.count(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: size,
          mainAxisSpacing: spacing,
          crossAxisSpacing: spacing,
          children: dummyTiles,
        ),
      ],
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
}

abstract class _TileFontSize {
  static double small = 36;
  static double medium = 50;
  static double large = 54;
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
    required this.tileFontSize,
    required this.state,
  }) : super(key: key);

  /// The tile to be displayed.
  final Tile tile;

  /// The font size of the tile to be displayed.
  final double tileFontSize;

  /// The state of the puzzle.
  final PuzzleState state;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        primary: PuzzleColors.white,
        textStyle: PuzzleTextStyle.headline2.copyWith(
          fontSize: tileFontSize,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(12),
          ),
        ),
      ).copyWith(
        foregroundColor: MaterialStateProperty.all(PuzzleColors.white),
        backgroundColor: MaterialStateProperty.resolveWith<Color?>(
          (states) {
            if (tile.id == state.lastTappedTile?.id) {
              return PuzzleColors.primary7;
            } else if (states.contains(MaterialState.hovered)) {
              return PuzzleColors.primary3;
            } else {
              return PuzzleColors.primary5;
            }
          },
        ),
      ),
      // TODO onDragged event or gesture listener
      onPressed: state.puzzleStatus == PuzzleStatus.incomplete
          ? () => context.read<PuzzleBloc>().add(TileDragged(tile,Direction.north))
          : null,
      child: Text(tile.id.toString()),
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
