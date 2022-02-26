import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:ruby_robbery/helper/preferences.dart';
import 'package:ruby_robbery/helper/themeProvider.dart';
import 'package:ruby_robbery/helper/utils.dart';
import 'package:ruby_robbery/l10n/l10n.dart';
import 'package:ruby_robbery/models/level_model.dart';
import 'package:ruby_robbery/models/levels.dart';
import 'package:ruby_robbery/pages/puzzle_page.dart';
import 'package:ruby_robbery/pages/shop_page.dart';
import 'package:ruby_robbery/widgets/widgets.dart';

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
  late Levels levels;

  @override
  void initState() {
    super.initState();
    prefs = Preferences();
    levels = Levels();
    WidgetsBinding.instance?.addObserver(this);

    try {
      /*await*/ prefs.load();
      Provider.of<ThemeProvider>(context, listen: false).initThemeProvider();
      initPlatformState();
      checkVersion();
      return;
    } on Exception catch (e) {
      print(e);
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
                onPressed: () => levelPage(),
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
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              child: RubyButton(
                key: const Key('shop_button'),
                onPressed: () => shop(),
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    context.l10n.menuShop,
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
    PuzzleResult? result = prefs.getSavedPuzzleResult();

    if (result != null && result.numMoves != null) {
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PuzzlePage(
            level: levels.getLevelById(result.level),
            puzzleResult: result,
        )),
      );

    } else {
      Level? level;
      if (result == null) {
        level = levels.getLevelById('000');
      } else {
        level = getNextUnsolvedLevel(result.level, levels, prefs.solvedLevels, prefs.unlockedLevels);
        if (level == null) {
          levelPage();
          return;
        }
        print('load level ' + level.id);
      }
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => PuzzlePage(level: level!)),
      );
    }
  }

  void levelPage() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const LevelsPage()),
    );
  }

  void settings() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const SettingsPage()),
    );
  }

  void shop() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => const ShopPage()),
    );
  }
}
