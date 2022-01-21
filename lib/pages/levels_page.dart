import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruby_theft/helper/preferences.dart';
import 'package:ruby_theft/models/level_model.dart';
import 'package:ruby_theft/models/levels.dart';

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
    return Container(
      decoration: const BoxDecoration(
      image: DecorationImage(
        repeat: ImageRepeat.repeat,
        image: AssetImage('images/bg_pattern.png'),
        scale: 15.0,
        opacity: 0.2,
        // colorFilter: ColorFilter.mode(Colors.white, BlendMode.hue)
      )
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: levelList(),
        ),
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
    print('level ' + level.id);
    return Container(
      child: Text(level.nameKey),
      color: Colors.blue,
    );
  }
}
