import 'package:flutter/material.dart';

import 'color_schemes.dart';
import 'text_themes.dart';

/// Text theme for the application.
class ThemeNotifier extends ChangeNotifier {
  /// Whether the theme mode has been loaded.
  bool _themeLoaded = false;
  bool get themeLoaded => _themeLoaded;

  /// Whether the application is in dark mode.
  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;

  /// The current theme mode.
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  /// The dark mode theme data.
  ThemeData get darkTheme => ThemeData(
        useMaterial3: true,
        colorScheme: PortfolioColorSchemes.dark,
        textTheme: PortfolioTextThemes.dark,
      );

  /// The light mode theme data.
  ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: PortfolioColorSchemes.light,
        textTheme: PortfolioTextThemes.light,
      );

  /// Loads the initial theme based on the system theme.
  void loadInitialTheme(BuildContext context) {
    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;
    _isDarkMode = platformBrightness == Brightness.dark;
    _themeLoaded = true;
    notifyListeners();
  }

  /// Sets the user's theme preference in shared preferences.
  void toggleThemeMode() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}
