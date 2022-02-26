import 'package:flutter/material.dart';
import 'package:ruby_robbery/helper/preferences.dart';
import 'package:ruby_robbery/pages/shop_page.dart';
import 'package:ruby_robbery/widgets/ruby_button.dart';

/// this file will collect styles for use across the app

class ScreenBox extends StatelessWidget {
  const ScreenBox({
    Key? key,
    required this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              repeat: ImageRepeat.repeat,
              image: AssetImage('assets/images/bg_pattern.png'),
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
        ),
        rubiesDisplay(context),
      ],
    );
  }

  rubiesDisplay(BuildContext context) {
    Preferences preferences = Preferences();
    int rubies = preferences.getRubies();

    return Positioned(
      left: 0,
      bottom: 30.0,
      child: RubyButton(
        child: Row(
          children: [
            const Image(
                  width: 20,
                  height: 20,
                  image: AssetImage('assets/images/ruby.png'),
            ),
            Text(' '+rubies.toString()),
        ]),
        onPressed: () => shop(context),
      ),
    );
  }

  void shop(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ShopPage()),
    );
  }
}
