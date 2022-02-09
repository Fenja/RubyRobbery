import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruby_robbery/helper/preferences.dart';
import 'package:ruby_robbery/helper/utils.dart';
import 'package:ruby_robbery/l10n/l10n.dart';
import 'package:ruby_robbery/layout/layout.dart';
import 'package:ruby_robbery/models/models.dart';
import 'package:ruby_robbery/pages/home_page.dart';
import 'package:ruby_robbery/pages/ruby_dialog.dart';
import 'package:ruby_robbery/puzzle/puzzle.dart';
import 'package:ruby_robbery/widgets/widgets.dart';
import 'package:ruby_robbery/timer/timer.dart';

import 'levels_page.dart';

/// {@template puzzle_page}
/// The root page of the puzzle UI.
///
/// Builds the puzzle based on the current [PuzzleTheme]
/// from [ThemeBloc].
/// {@endtemplate}
class PuzzlePage extends StatelessWidget {
  /// {@macro puzzle_page}
  PuzzlePage({
    Key? key,
    required this.level,
    this.puzzleResult
  }) : super(key: key);

  /// the level to display on the puzzle page
  final Level level;

  /// optional param to reload last session
  PuzzleResult? puzzleResult;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text(level.nameKey),
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).popUntil((route) => route.isFirst);
            }),
      ),
      body: ScreenBox(
        child: BlocProvider(
          create: (context) => TimerBloc(
            ticker: const Ticker(),
          ),
          child: BlocProvider(
            create: (context) => PuzzleBloc(level)
              ..add(
                const PuzzleInitialized(),
              ),
            child: const _Puzzle(
              key: Key('puzzle_view_puzzle'),
            ),
          ),
        ),
      )
    );
  }
}

class _Puzzle extends StatelessWidget {
  const _Puzzle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Stack(
          children: [
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(
                  minHeight: constraints.maxHeight,
                ),
                child: Column(
                  children: [
                    _PuzzleSections(
                      key: const Key('puzzle_sections'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}

class _PuzzleSections extends StatelessWidget {
  _PuzzleSections({Key? key}) : super(key: key);

  Preferences preferences = Preferences();
  Levels levels = Levels();

  @override
  Widget build(BuildContext context) {
    final state = context.select((PuzzleBloc bloc) => bloc.state);
    final level = context.select((PuzzleBloc bloc) => bloc.level.id);

    if (state.puzzleStatus == PuzzleStatus.complete) showSolvedDialog(context, level);

    return ResponsiveLayoutBuilder(
      small: (context, child) => Column(
        children: [
          _startSectionBuilder(state, level),
          const PuzzleBoard(),
          _endSectionBuilder(state),
        ],
      ),
      medium: (context, child) => Column(
        children: [
          _startSectionBuilder(state, level),
          const PuzzleBoard(),
          _endSectionBuilder(state),
        ],
      ),
      large: (context, child) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _startSectionBuilder(state, level),
          ),
          const PuzzleBoard(),
          Expanded(
            child: _endSectionBuilder(state),
          ),
        ],
      ),
    );
  }

  Widget _startSectionBuilder(PuzzleState state, String levelId) {
    return ResponsiveLayoutBuilder(
      small: (_, child) => child!,
      medium: (_, child) => child!,
      large: (_, child) => Padding(
        padding: const EdgeInsets.only(left: 50, right: 32),
        child: child,
      ),
      child: (_) => StartSection(state: state, levelId: levelId,),
    );
  }

  Widget _endSectionBuilder(PuzzleState state) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
        ResponsiveLayoutBuilder(
          small: (_, child) => PuzzleResetButton(state: state),
          medium: (_, child) => PuzzleResetButton(state: state),
          large: (_, __) => const SizedBox(),
        ),
        const ResponsiveGap(
          small: 32,
          medium: 48,
        ),
      ],
    );
  }

  void showSolvedDialog(BuildContext context, String levelId) async{

    Level level = levels.getLevelById(levelId);
    int reward = preferences.getSolvedLevels().contains(levelId) ? level.rubyRepeat : level.rubyReward;

    preferences.solveLevel(levelId);
    preferences.addRubies(reward);
    preferences.saveCurrentPuzzleState(PuzzleResult(level: levelId));

    await Future.delayed(const Duration(milliseconds: 50));
    showDialog(
        context: context,
        builder: (context) {
          return RubyDialog(
            title: context.l10n.dialogSolvedPuzzleTitle,
            content: Column(
              children: [
                Text(
                    reward.toString()
                ),
              ],
            ), actions: [
            TextButton(
              onPressed: () => {
                Navigator.pop(context),
                nextLevel(context, levelId),
              },
              child: Text(context.l10n.buttonNextLevel),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => {
                Navigator.pop(context),
                homeMenu(context),
              },
              child: Text(context.l10n.buttonBreak),
            ),
          ],
          );
        }
    );
  }

  void nextLevel(BuildContext context, String levelId) {
    Level? level = getNextLevel(levelId, levels, preferences.unlockedLevels);
    if (level == null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const LevelsPage()),
      );
      return;
    } else {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PuzzlePage(level: level)),
      );
    }
  }

  homeMenu(BuildContext context) {
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => const HomePage()), (Route<dynamic> route) => false);
  }
}

/// {@template puzzle_board}
/// Displays the board of the puzzle.
/// {@endtemplate}
class PuzzleBoard extends StatelessWidget {
  /// {@macro puzzle_board}
  const PuzzleBoard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final puzzle = context.select((PuzzleBloc bloc) => bloc.state.puzzle);

    final size = puzzle.dimension;
    if (size == 0) return const CircularProgressIndicator();

    return BlocListener<PuzzleBloc, PuzzleState>(
      listener: (context, state) {
        if (state.puzzleStatus == PuzzleStatus.complete) {
          context.read<TimerBloc>().add(const TimerStopped());
        }
      },
      child: _boardBuilder(puzzle),
    );
  }

  Widget _boardBuilder(Puzzle puzzle) {
    return Column(
      children: [
        const ResponsiveGap(
          small: 32,
          medium: 48,
          large: 96,
        ),
        ResponsiveLayoutBuilder(
          small: (_, __) => SizedBox.square(
            dimension: _BoardSize.small,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_small'),
              puzzle: puzzle,
              spacing: 5,
            ),
          ),
          medium: (_, __) => SizedBox.square(
            dimension: _BoardSize.medium,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_medium'),
              puzzle: puzzle,
            ),
          ),
          large: (_, __) => SizedBox.square(
            dimension: _BoardSize.large,
            child: SimplePuzzleBoard(
              key: const Key('simple_puzzle_board_large'),
              puzzle: puzzle,
            ),
          ),
        ),
        const ResponsiveGap(
          large: 96,
        ),
      ],
    );
  }
}

abstract class _BoardSize {
  static double small = 312;
  static double medium = 424;
  static double large = 472;
}
