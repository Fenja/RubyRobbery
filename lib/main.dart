import 'app/view/app.dart';
import 'bootstrap.dart';

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
