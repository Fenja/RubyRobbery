import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:ruby_theft/l10n/l10n.dart';
import 'app/view/app.dart';
import 'bootstrap.dart';
import 'helper/themeProvider.dart';
import 'pages/home_page.dart';

void main() {
  bootstrap(() => const App());
}
/*
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ],
        child: const RubyTheftApp(),
      )
  );
}*/
