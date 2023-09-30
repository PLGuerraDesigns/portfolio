import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_schemes.g.dart';

/// Text theme for the application.
class ThemeNotifier extends ChangeNotifier {
  /// Whether the application is in dark mode.
  bool _isDarkMode = true;
  bool get isDarkMode => _isDarkMode;
  bool themeLoaded = false;

  void loadInitialTheme(BuildContext context) {
    final Brightness platformBrightness =
        MediaQuery.of(context).platformBrightness;
    _isDarkMode = platformBrightness == Brightness.dark;
    themeLoaded = true;
    notifyListeners();
  }

  /// Sets the user's theme preference in shared preferences.
  void setDarkTheme(bool enabled) {
    _isDarkMode = enabled;
    notifyListeners();
  }
}

// As specified by the Material Design guidelines.
// https://m3.material.io/styles/typography/type-scale-tokens#7ab6f2b4-6217-4182-9ae1-3371a74f8b00

/// A light background text theme.
final TextTheme lightTextTheme = TextTheme(
  displayLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 57,
    height: 64 / 57,
    letterSpacing: -0.25,
    color: lightColorScheme.onSurface,
  ),
  displayMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 45,
    height: 52 / 45,
    color: lightColorScheme.onSurface,
  ),
  displaySmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 36,
    height: 44 / 36,
    color: lightColorScheme.onSurface,
  ),
  headlineLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 32,
    height: 40 / 32,
    color: lightColorScheme.onSurface,
  ),
  headlineMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 28,
    height: 36 / 28,
    color: lightColorScheme.onSurface,
  ),
  headlineSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 32 / 24,
    color: lightColorScheme.onSurface,
  ),
  titleLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 22,
    height: 28 / 22,
    color: lightColorScheme.onSurface,
  ),
  titleMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.15,
    color: lightColorScheme.onSurface,
  ),
  titleSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
    color: lightColorScheme.onSurface,
  ),
  bodyLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.5,
    color: lightColorScheme.onSurface,
  ),
  bodyMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.25,
    color: lightColorScheme.onSurface,
  ),
  bodySmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.4,
    color: lightColorScheme.onSurface,
  ),
  labelLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
    color: lightColorScheme.onSurface,
  ),
  labelMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.5,
    color: lightColorScheme.onSurface,
  ),
  labelSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 11,
    height: 16 / 11,
    letterSpacing: 0.5,
    color: lightColorScheme.onSurface,
  ),
);

/// A dark background text theme.
final TextTheme darkTextTheme = TextTheme(
  displayLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 57,
    height: 64 / 57,
    letterSpacing: -0.25,
    color: darkColorScheme.onSurface,
  ),
  displayMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 45,
    height: 52 / 45,
    color: darkColorScheme.onSurface,
  ),
  displaySmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 36,
    height: 44 / 36,
    color: darkColorScheme.onSurface,
  ),
  headlineLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 32,
    height: 40 / 32,
    color: darkColorScheme.onSurface,
  ),
  headlineMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 28,
    height: 36 / 28,
    color: darkColorScheme.onSurface,
  ),
  headlineSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 24,
    height: 32 / 24,
    color: darkColorScheme.onSurface,
  ),
  titleLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 22,
    height: 28 / 22,
    color: darkColorScheme.onSurface,
  ),
  titleMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.15,
    color: darkColorScheme.onSurface,
  ),
  titleSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
    color: darkColorScheme.onSurface,
  ),
  bodyLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 16,
    height: 24 / 16,
    letterSpacing: 0.5,
    color: darkColorScheme.onSurface,
  ),
  bodyMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.25,
    color: darkColorScheme.onSurface,
  ),
  bodySmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w400,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.4,
    color: darkColorScheme.onSurface,
  ),
  labelLarge: GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 14,
    height: 20 / 14,
    letterSpacing: 0.1,
    color: darkColorScheme.onSurface,
  ),
  labelMedium: GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 12,
    height: 16 / 12,
    letterSpacing: 0.5,
    color: darkColorScheme.onSurface,
  ),
  labelSmall: GoogleFonts.roboto(
    fontWeight: FontWeight.w500,
    fontSize: 11,
    height: 16 / 11,
    letterSpacing: 0.5,
    color: darkColorScheme.onSurface,
  ),
);
