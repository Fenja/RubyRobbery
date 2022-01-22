import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruby_theft/helper/preferences.dart';
import 'package:ruby_theft/models/level_model.dart';
import 'package:ruby_theft/models/levels.dart';
import 'package:ruby_theft/puzzle/puzzle.dart';
import 'package:ruby_theft/theme/widgets/widgets.dart';

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
          return levelWidget(levelList[index]);
        }
    );
  }

  Widget levelWidget(Level level) {
    return RubyButton(
      key: Key('level_button'+level.id),
      child: Text(level.nameKey),
      onPressed: () => _loadLevel(level),
    );
  }

  void _loadLevel(level) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => PuzzlePage(level: level)),
    );
  }
}
