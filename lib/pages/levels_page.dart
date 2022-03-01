import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruby_robbery/helper/preferences.dart';
import 'package:ruby_robbery/l10n/l10n.dart';
import 'package:ruby_robbery/models/models.dart';
import 'package:ruby_robbery/pages/puzzle_page.dart';
import 'package:ruby_robbery/pages/ruby_dialog.dart';
import 'package:ruby_robbery/widgets/widgets.dart';

import '../helper/sound_module.dart';

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
            onPressed: () => isUnlocked ? _loadLevel(context, level) : unlockLevel(context, level),
          );
        }
    );
  }

  void _loadLevel(context, Level level) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PuzzlePage(level: level)),
    );
  }

  void unlockLevel(context, Level level) {
    showDialog(
        context: context,
        builder: (context) {
          return RubyDialog(
              title: context.l10n.unlockLevel,
              content: Column(
                children: [
                  Text(level.nameKey),
                  Text(context.l10n.lockedLevelText),
                  Row(
                    children: [
                      const Image(
                        width: 20,
                        height: 20,
                        image: AssetImage('assets/images/ruby.png'),
                      ),
                      Text(' '+level.rubyCost.toString()),
                    ],
                  )
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(context.l10n.buttonCancel),
                ),
                TextButton(
                  onPressed: () => {
                    Navigator.pop(context),
                    _unlockLevel(context, level),
                  },
                  child: Text(context.l10n.buttonOk),
                ),
              ]
          );
        }
    );
  }

  void _unlockLevel(context, Level level) {
    setState(() {
      bool unlocked = prefs.buyLevel(level);
      if (unlocked) {
        playSound();
        print('successfully unlocked');
        // TODO snackbar success & setState
      } else {
        print('too expensive');
        // TODO snackbar too expensive
      }
    });

  }

  playSound() async {
    SoundModule soundModule = SoundModule();
    soundModule.playSound(soundModule.LEVEL_UNLOCK_SOUND);
  }

  bool _isUnlocked(String levelId) {
    return prefs.getUnlockedLevels().contains(levelId);
  }

  bool _isSolved(String levelId) {
    return prefs.getSolvedLevels().contains(levelId);
  }
}
