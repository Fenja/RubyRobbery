import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// this file will collect styles for use across the app

class ScreenBox extends StatelessWidget {
  const ScreenBox({
    Key? key,
    required this.child
  }) : super(key: key);

  final Widget child;

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
        ),
      ),
      alignment: FractionalOffset.center,
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0, bottom: 5.0, top: 5.0),
      child: SizedBox(
          width: 600,
          child: child
      ),
    );
  }
}
