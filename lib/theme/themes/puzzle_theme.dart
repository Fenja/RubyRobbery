import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:ruby_theft/layout/layout.dart';

/// {@template puzzle_theme}
/// Template for creating custom puzzle UI.
/// {@endtemplate}
abstract class PuzzleTheme extends Equatable {
  /// {@macro puzzle_theme}
  const PuzzleTheme();

  /// The display name of this theme.
  String get name;

  /// Whether this theme displays the puzzle timer.
  bool get hasTimer;

  /// The background color of this theme.
  Color get backgroundColor;

  /// The default color of this theme.
  ///
  /// Used for puzzle tiles and buttons.
  Color get defaultColor;

  /// The hover color of this theme.
  ///
  /// Used for the puzzle tile that was hovered over.
  Color get hoverColor;

  /// The pressed color of this theme.
  ///
  /// Used for the puzzle tile that was pressed.
  Color get pressedColor;

  /// The puzzle layout delegate of this theme.
  ///
  /// Used for building sections of the puzzle UI.
  PuzzleLayoutDelegate get layoutDelegate;
}
