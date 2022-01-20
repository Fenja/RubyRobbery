import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ruby_theft/helper/preferences.dart';

class LevelsPage extends StatefulWidget {
  const LevelsPage({Key? key}) : super(key: key);

  @override
  _LevelsPageState createState() => _LevelsPageState();
}

class _LevelsPageState extends State<LevelsPage> {
  Preferences prefs = Preferences();

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
        body: Center(child: Text('Levels')),
      ),
    );
  }
}
