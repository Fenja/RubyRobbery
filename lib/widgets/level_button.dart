import 'package:flutter/material.dart';
import 'package:ruby_theft/models/level_model.dart';
import 'package:ruby_theft/widgets/ruby_button.dart';

class LevelButton extends StatelessWidget {
  const LevelButton({
    Key? key,
    required this.level,
    required this.isUnlocked,
    required this.isSolved,
    required this.onPressed
  }) : super(key: key);

  /// the level of question
  final Level level;

  /// the user has unlocked this level with rubies
  final bool isUnlocked;

  /// the user solved this level before
  final bool isSolved;

  /// action to happen on level tap
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10.0),
      child:
        RubyButton(
          key: Key('level_button'+level.id),
          child: isUnlocked ?
              playable() :
              lock(),
          onPressed: onPressed,
        )
    );
  }

  Widget title() {
    return Center(child: Text(level.nameKey) );
  }

  Widget playable() {
    return Column(
      children: [
        solved(),
        difficulty(),
        title()
      ]);
  }

  Widget lock() {
    return Column(
      children: [
        const Expanded( child: Icon(Icons.lock) ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(level.rubyCost.toString()+' '),
            const Expanded(
                child: Image(
                  width: 20,
                  height: 20,
                  image: AssetImage('assets/images/ruby.png'),
              )
            )
          ],
        )
      ],
    );
  }

  Widget difficulty() {
    // display three stars
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: star(level.difficulty >= 1)),
        Expanded(child: star(level.difficulty >= 2)),
        Expanded(child: star(level.difficulty >= 3)),
      ],
    );
  }

  Widget star(bool isFilled) {
    return Icon(
      Icons.star,
      color: isFilled ? Colors.amber : Colors.black,
    );
  }

  Widget solved() {
    final String imageName = level.hasPearls ? 'pearl' /*: level.hasOpals ? 'opal'*/ : 'diamond1';
    if (isSolved) {
      return Expanded(
          child: Image(
            width: 30,
            height: 30,
            image: AssetImage('assets/images/'+imageName+'.png'),
          )
      );
    } else {
      return Expanded(
          child: ImageIcon(
            AssetImage('assets/images/'+imageName+'.png'),
            size: 30,
          )
      );
    }
  }
}
