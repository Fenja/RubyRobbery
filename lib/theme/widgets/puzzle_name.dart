import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ruby_theft/colors/colors.dart';
import 'package:ruby_theft/layout/layout.dart';
import 'package:ruby_theft/theme/theme.dart';
import 'package:ruby_theft/typography/typography.dart';

/// {@template puzzle_name}
/// Displays the name of the current puzzle theme.
/// Visible only on a large layout.
/// {@endtemplate}
class PuzzleName extends StatelessWidget {
  /// {@macro puzzle_name}
  const PuzzleName({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final name = context.select((ThemeBloc bloc) => bloc.state.theme).name;

    return ResponsiveLayoutBuilder(
      small: (context, child) => const SizedBox(),
      medium: (context, child) => const SizedBox(),
      large: (context, child) => Text(
        name,
        style: PuzzleTextStyle.headline5.copyWith(
          color: PuzzleColors.grey1,
        ),
      ),
    );
  }
}
