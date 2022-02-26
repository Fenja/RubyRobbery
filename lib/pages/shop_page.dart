import 'package:flutter/material.dart';
import 'package:ruby_robbery/helper/preferences.dart';
import 'package:ruby_robbery/l10n/l10n.dart';

import '../widgets/screen_box.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({Key? key}): super(key: key);

  @override
  _ShopPageState createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  Preferences preferences = Preferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.menuShop) ),
      body: ScreenBox(
          child: _shop()
      ),
    );
  }

  Widget _shop() {
    return PageView(
      scrollDirection: Axis.horizontal,
      children: [
        Text('here will be content')
      ],
    );
  }
}
