import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'common/color_schemes.g.dart';
import 'common/strings.dart';
import 'common/theme.dart';
import 'screens/home.dart';

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

    return ChangeNotifierProvider<ThemeNotifier>.value(
      value: themeNotifier,
      child: MaterialApp(
        title: Strings.appName,
        themeMode: themeNotifier.isDarkMode ? ThemeMode.dark : ThemeMode.light,
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: lightColorScheme,
          textTheme: lightTextTheme,
        ),
        darkTheme: ThemeData(
          useMaterial3: true,
          colorScheme: darkColorScheme,
          textTheme: darkTextTheme,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
