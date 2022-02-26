import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ruby_robbery/helper/preferences.dart';
import 'package:ruby_robbery/l10n/l10n.dart';
import 'package:ruby_robbery/pages/privacy_policy_page.dart';
import 'package:ruby_robbery/widgets/widgets.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Preferences preferences = Preferences();
  //PackageInfo packageInfo = PackageInfo.fromPlatform() as PackageInfo; // naaah

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.menuSettings) ),
      body: ScreenBox(
        child: _settings()
      ),
    );
  }

  Widget _settings() {
    return ListView(
      children: [
        !kIsWeb
          ? ListTile( title: Text(context.l10n.version + ': ' + (preferences.getVersion() ?? 'new') ))
          : const SizedBox(),

        audio(),
        credits(),

        ListTile(
            title: Text(context.l10n.privacyPolicy),
            onTap: () => _privacyPolicy()
        )
      ],
    );
  }

  Widget audio() {
    return const SizedBox();
  }

  Widget credits() {
    return const SizedBox();

    // free sounds from mixkit.co https://mixkit.co/free-sound-effects/game
  }

  void _privacyPolicy() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
    );
  }
}
