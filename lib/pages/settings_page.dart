import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  PackageInfo packageInfo = PackageInfo.fromPlatform() as PackageInfo; // naaah

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
        body: Center(child: Text('Settings')),
      ),
    );
  }
}
