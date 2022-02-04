import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruby_theft/helper/preferences.dart';
import 'package:ruby_theft/l10n/l10n.dart';
import 'package:ruby_theft/models/models.dart';
import 'package:ruby_theft/pages/puzzle_page.dart';
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
      appBar: AppBar(title: Text(context.l10n.menuLevels) ),
      body: ScreenBox(
        child: levelList(),
      )
    );
  }

  Widget levelList() {
    List<Level> levelList = levels.getAllLevels();
    return GridView.builder(
        key: const Key('level_list'),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: MediaQuery.of(context).size.width < 600 ? 3 : MediaQuery.of(context).size.width > 1000 ? 5 : 4,
        ),
        itemCount: levelList.length,
        itemBuilder: (BuildContext context, index) {
          Level level = levelList[index];
          bool isUnlocked = level.unlocked || _isUnlocked(level.id);
          return LevelButton(
            level: level,
            isUnlocked: isUnlocked,
            isSolved: _isSolved(level.id),
            onPressed: () => isUnlocked ? _loadLevel(context, level) : _unlockLevel(context, level),
          );
        }
    );
  }

  void _loadLevel(context, Level level) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PuzzlePage(level: level)),
    );
  }

  void _unlockLevel(context, Level level) {
    setState(() {
      bool unlocked = prefs.buyLevel(level);
      if (unlocked) {
        print('successfully unlocked');
        // TODO snackbar success & setState
      } else {
        print('too expensive');
        // TODO snackbar too expensive
      }
    });

  }

  bool _isUnlocked(String levelId) {
    return prefs.getUnlockedLevels().contains(levelId);
  }

  bool _isSolved(String levelId) {
    return prefs.getSolvedLevels().contains(levelId);
  }
}
