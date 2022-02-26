// Copyright (c) 2021, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: public_member_api_docs

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ruby_robbery/colors/colors.dart';
import 'package:ruby_robbery/helper/sound_module.dart';
import 'package:ruby_robbery/models/levels.dart';
import 'package:ruby_robbery/pages/home_page.dart';

class App extends StatefulWidget {
  const App({Key? key}) : super(key: key);

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    if (!kIsWeb) {
      SoundModule soundModule = SoundModule();
      soundModule.startBackgroundMusic();
    }
  }

  @override
  Widget build(BuildContext context) {
    Levels levels = Levels();
    //final themeProvider = Provider.of<ThemeProvider>(context, listen: true);

    return MaterialApp(
      theme: ThemeData(
        primaryColor: PuzzleColors.primary1,
        colorScheme: const ColorScheme.light()
        .copyWith(primary: PuzzleColors.primary1),
      ),
      darkTheme: ThemeData(
        primaryColor: PuzzleColors.primary2,
        colorScheme: const ColorScheme.dark()
            .copyWith(primary: PuzzleColors.primary2),
      ),
      //themeMode: themeProvider.themeMode,

      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,

      home: const HomePage(),
    );
  }
}
