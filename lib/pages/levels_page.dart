import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruby_theft/helper/preferences.dart';
import 'package:ruby_theft/models/models.dart';
import 'package:ruby_theft/widgets/widgets.dart';

class LevelsPage extends StatefulWidget {
  const LevelsPage({Key? key}) : super(key: key);

  @override
  _LevelsPageState createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  Preferences prefs = Preferences();
  Levels levels = Levels();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBox(
        child: levelList(),
      )
    );
  }

  Widget levelList() {
    List<Level> levelList = levels.getAllLevels();
    return GridView.builder(
        key: const Key('level_list'),
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 100,
        ),
        itemCount: levelList.length,
        itemBuilder: (BuildContext context, index) {
          Level level = levelList[index];
          return LevelButton(
            level: level,
            isUnlocked: level.unlocked || _isUnlocked(level.id),
            isSolved: _isSolved(level.id)
          );
        }
    );
  }

  bool _isUnlocked(String levelId) {
    return prefs.getUnlockedLevels().contains(levelId);
  }

  bool _isSolved(String levelId) {
    return prefs.getSolvedLevels().contains(levelId);
  }
}
