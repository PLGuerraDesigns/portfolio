import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/routing/app_router.dart';
import 'common/strings.dart';
import 'common/theming/theme_notifier.dart';
import 'models/app_state.dart';

void main() {
  runApp(const PortfolioApp());
}

/// The entry point of the application.
class PortfolioApp extends StatefulWidget {
  const PortfolioApp({super.key});

  @override
  State<PortfolioApp> createState() => _PortfolioAppState();
}

class _PortfolioAppState extends State<PortfolioApp> {
  /// The theme notifier to listen to theme changes.
  late final ThemeNotifier themeNotifier = ThemeNotifier();

  /// The application state.
  final AppState _appState = AppState();

  @override
  void initState() {
    super.initState();

    // Listen to theme changes and rebuild the application.
    themeNotifier.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    // Load the initial theme (based on the system theme)
    if (!themeNotifier.themeLoaded) {
      themeNotifier.loadInitialTheme(context);
    }

    return MultiProvider(
      providers: <ChangeNotifierProvider<dynamic>>[
        ChangeNotifierProvider<ThemeNotifier>.value(value: themeNotifier),
        ChangeNotifierProvider<AppState>.value(value: _appState),
      ],
      child: MaterialApp.router(
        title: Strings.appName,
        theme: themeNotifier.lightTheme,
        darkTheme: themeNotifier.darkTheme,
        themeMode: themeNotifier.themeMode,
        routerConfig: AppRouter(_appState).configureRouter(),
      ),
    );
  }
}
