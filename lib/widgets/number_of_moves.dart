import 'package:flutter/material.dart';
import 'package:ruby_robbery/colors/colors.dart';
import 'package:ruby_robbery/l10n/l10n.dart';
import 'package:ruby_robbery/layout/layout.dart';
import 'package:ruby_robbery/typography/typography.dart';

/// {@template number_of_moves}
/// Displays how many moves have been made on the current puzzle
/// {@endtemplate}
class NumberOfMoves extends StatelessWidget {
  /// {@macro number_of_moves}
  const NumberOfMoves({
    Key? key,
    required this.numberOfMoves,
    this.color,
  }) : super(key: key);

  /// The number of moves to be displayed.
  final int numberOfMoves;

  /// The color of texts that display [numberOfMoves].
  /// Defaults to [PuzzleTheme.defaultColor].
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textColor = color ?? PuzzleColors.primary5;

    return ResponsiveLayoutBuilder(
      small: (context, child) => Center(child: child),
      medium: (context, child) => Center(child: child),
      large: (context, child) => child!,
      child: (currentSize) {
        final bodyTextStyle = currentSize == ResponsiveLayoutSize.small
            ? PuzzleTextStyle.bodySmall
            : PuzzleTextStyle.body;

        return RichText(
          key: const Key('numberOfMovesAndTilesLeft'),
          textAlign: TextAlign.center,
          text: TextSpan(
            text: numberOfMoves.toString(),
            style: PuzzleTextStyle.headline4.copyWith(
              color: textColor,
            ),
            children: [
              TextSpan(
                text: ' ${l10n.puzzleNumberOfMoves} | ',
                style: bodyTextStyle.copyWith(
                  color: textColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
