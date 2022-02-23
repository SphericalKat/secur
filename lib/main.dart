import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:secur/internal/router/app_router.gr.dart';
import 'package:secur/internal/themes.dart';
import 'package:secur/ui/common/secur_app_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized;
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  runApp(
    MyApp(
      savedThemeMode: savedThemeMode,
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({Key? key, this.savedThemeMode}) : super(key: key);

  final AdaptiveThemeMode? savedThemeMode;
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.system,
      builder: (light, dark) => MaterialApp.router(
        title: 'Secur',
        theme: light,
        darkTheme: dark,
        routerDelegate: _appRouter.delegate(),
        routeInformationParser: _appRouter.defaultRouteParser(),
      ),
    );
  }
}
