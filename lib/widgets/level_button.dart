import 'package:flutter/material.dart';
import 'package:ruby_theft/helper/preferences.dart';
import 'package:ruby_theft/models/level_model.dart';
import 'package:ruby_theft/pages/puzzle_page.dart';
import 'package:ruby_theft/widgets/ruby_button.dart';

class LevelButton extends StatelessWidget {
  const LevelButton({
    Key? key,
    required this.level,
    required this.isUnlocked,
    required this.isSolved
  }) : super(key: key);

  /// the level of question
  final Level level;

  /// the user has unlocked this level with rubies
  final bool isUnlocked;

  /// the user solved this level before
  final bool isSolved;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child: isUnlocked ?
        RubyButton(
          key: Key('level_button'+level.id),
          child: Column(
            children: [
              solved(),
              difficulty(),
              title()
            ],
          ),
          onPressed: () => _loadLevel(context),
        ) :
        lock(),
    );
  }

  void _loadLevel(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PuzzlePage(level: level)),
    );
  }

  Widget title() {
    return Center(child: Text(level.nameKey) );
  }

  Widget difficulty() {
    // display three stars
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        star(level.difficulty >= 1),
        star(level.difficulty >= 2),
        star(level.difficulty >= 3),
      ],
    );
  }

  Widget star(bool isFilled) {
    return Expanded(
      child: Icon(
        Icons.star,
        color: isFilled ? Colors.amber : Colors.black,
      )
    );
  }

  Widget solved() {
    return Center(
      child: Expanded(
        child: Icon(
          Icons.circle,
          color: isSolved ? Colors.redAccent : Colors.black,
        )
      )
    );
  }

  Widget lock() {
    return Container(
        color: Colors.deepPurple,
        child: Center(
          child: Column(
            children: [
              IconButton(
                  onPressed: () => unlockLevel(),
                  icon: const Icon(Icons.lock)
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(level.rubyCost.toString()+' '),
                  const Icon(Icons.circle, color: Colors.redAccent)
                ],
              )
            ],
          )
        ),
      );
  }

  void unlockLevel() {
    Preferences preferences = Preferences();
    // TODO does not work inside levelButton
    // I need preferences and context!
    bool unlocked = preferences.buyLevel(level);
    if (unlocked) {
      // TODO snackbar success & setState
    } else {
      // TODO snackbar too expensive
    }
  }
}
