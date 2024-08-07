// As specified by the Material Design guidelines.
// https://m3.material.io/styles/typography/type-scale-tokens#7ab6f2b4-6217-4182-9ae1-3371a74f8b00

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'color_schemes.dart';

/// Text themes for the application.
class PortfolioTextThemes {
  PortfolioTextThemes._();

  /// A light background text theme.
  static final TextTheme light = TextTheme(
    displayLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 57,
      height: 64 / 57,
      letterSpacing: -0.25,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    displayMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 45,
      height: 52 / 45,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    displaySmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 36,
      height: 44 / 36,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    headlineLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 40 / 32,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      height: 36 / 28,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 32 / 24,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    titleLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 22,
      height: 28 / 22,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    titleMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.15,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    titleSmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.25,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    bodySmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    labelLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    labelMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
      color: PortfolioColorSchemes.light.onSurface,
    ),
    labelSmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 16 / 11,
      letterSpacing: 0.5,
      color: PortfolioColorSchemes.light.onSurface,
    ),
  );

  /// A dark background text theme.
  static final TextTheme dark = TextTheme(
    displayLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 57,
      height: 64 / 57,
      letterSpacing: -0.25,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    displayMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 45,
      height: 52 / 45,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    displaySmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 36,
      height: 44 / 36,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    headlineLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 32,
      height: 40 / 32,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    headlineMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 28,
      height: 36 / 28,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    headlineSmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 24,
      height: 32 / 24,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    titleLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 22,
      height: 28 / 22,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    titleMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.15,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    titleSmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w600,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    bodyLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 16,
      height: 24 / 16,
      letterSpacing: 0.5,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    bodyMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.25,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    bodySmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w400,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.4,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    labelLarge: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      height: 20 / 14,
      letterSpacing: 0.1,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    labelMedium: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 12,
      height: 16 / 12,
      letterSpacing: 0.5,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
    labelSmall: GoogleFonts.roboto(
      fontWeight: FontWeight.w500,
      fontSize: 11,
      height: 16 / 11,
      letterSpacing: 0.5,
      color: PortfolioColorSchemes.dark.onSurface,
    ),
  );
}
