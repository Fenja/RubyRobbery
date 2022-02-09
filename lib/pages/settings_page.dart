import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:ruby_robbery/helper/preferences.dart';
import 'package:ruby_robbery/l10n/l10n.dart';
import 'package:ruby_robbery/pages/privacy_policy_page.dart';
import 'package:ruby_robbery/widgets/widgets.dart';

import 'package:firebase_database/firebase_database.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Preferences preferences = Preferences();
  //PackageInfo packageInfo = PackageInfo.fromPlatform() as PackageInfo; // naaah
  FirebaseDatabase database = FirebaseDatabase.instance;

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
    return PageView(
      scrollDirection: Axis.horizontal,
      children: [
        general(),
        audio(),
        credits(),
        pp(),
      ],
    );
  }

  Widget general() {
    //final themeProvider = Provider.of<ThemeProvider>(context);
    //final appLanguage = Provider.of<AppLanguage>(context);

    return ListView(
      children: [
        !kIsWeb ? ListTile(
          title: Text(context.l10n.version + ': ' + (preferences.getVersion() ?? 'new') ),
        ) : const SizedBox(),
        /*SwitchListTile(
          value: themeProvider.isLightMode,
          onChanged: (value) => themeProvider.toggleTheme(value),
          title: themeProvider.isLightMode ?
          Text(context.l10n.lightMode) :
          Text(context.l10n.darkMode),
        ),*/
      ],
      // language
    );
  }

  Widget audio() {
    return SizedBox();
  }

  Widget credits() {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    print(ref.key);
    return SizedBox();
  }

  Widget pp() {
    return ListTile(
        title: Text(context.l10n.privacyPolicy),
        onTap: () => _privacyPolicy()
    );
  }

  void _privacyPolicy() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PrivacyPolicyPage()),
    );
  }
}
