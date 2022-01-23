import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:ruby_theft/helper/preferences.dart';
import 'package:ruby_theft/helper/themeProvider.dart';
import 'package:ruby_theft/l10n/l10n.dart';
import 'package:ruby_theft/pages/puzzle_page.dart';
import 'package:ruby_theft/widgets/widgets.dart';

import 'levels_page.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with WidgetsBindingObserver {

  late Preferences prefs;
  late PackageInfo packageInfo;

  @override
  void initState() {
    super.initState();
    prefs = Preferences();
    WidgetsBinding.instance?.addObserver(this);

    try {
      /*await*/ prefs.load();
      Provider.of<ThemeProvider>(context, listen: false).initThemeProvider();
      initPlatformState();
      checkVersion();
      return;
    } on Exception catch (e) {
      // TODO handle error
    }
  }

  Future<void> initPlatformState() async {
    /*await Purchases.setDebugLogsEnabled(true);
    await Purchases.setup("yKlVSnuHtIPZyhYqMWtREPIoMioiJgsA");
    PurchaserInfo purchaserInfo = await Purchases.getPurchaserInfo();
    //print('purchaserInfo: ' + purchaserInfo.toString());
    bool isProVersion = purchaserInfo.entitlements.all["no_advertisement"] != null && purchaserInfo.entitlements.all["no_advertisement"].isActive;
    prefs.setPurchasePro(isProVersion);*/
  }

  Future<void> checkVersion() async {
    String? savedVersion = prefs.getVersion();
    packageInfo = await PackageInfo.fromPlatform();
    String runningVersion = packageInfo.version;
    if (savedVersion == null) {
      //Template.showTutorial(context);
      prefs.setVersion(runningVersion);
    }
    if (savedVersion != runningVersion) {
      //Template.showUpdates(context);
      prefs.setVersion(runningVersion);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.appTitle),),
      body: ScreenBox(
        child: ListView(
          key: const Key('main_menu'),
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 32.0, right: 32.0, top: 50.0, bottom: 50.0),
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              child: RubyButton(
                key: const Key('play_button'),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    context.l10n.menuPlay,
                    textAlign: TextAlign.center,
                  )
                ),
                onPressed: () => play()
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: RubyButton(
                key: const Key('levels_button'),
                onPressed: () => levels(),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    context.l10n.menuLevels,
                    textAlign: TextAlign.center,
                  )
                )
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: RubyButton(
                key: const Key('settings_button'),
                onPressed: () => settings(),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    context.l10n.menuSettings,
                    textAlign: TextAlign.center,
                  )
                )
              ),
            )
          ],
        ),
      )
    );
  }

  void play() {
    /*Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const PuzzlePage()), // TODO load last game
    );*/
  }

  void levels() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LevelsPage()),
    );
  }

  void settings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }
}
