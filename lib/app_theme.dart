import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

abstract class CherryBlossomColors {
  // Light
  static const primary = Color(0xFFF2A7C3);
  static const primaryDark = Color(0xFFC2185B);
  static const secondary = Color(0xFFFFDADD);
  static const surface = Color(0xFFFFF5F7);
  static const onSurface = Color(0xFF2D1B20);
  static const accentGold = Color(0xFFE8C99A);
  static const buttonNumber = Color(0xFFFDEEF3);
  static const buttonOperator = Color(0xFFF7C5D8);
  static const buttonSpecial = Color(0xFFEDA8BF);
  static const displayExpression = Color(0xFFAD7D90);

  // Dark
  static const primaryDarkMode = Color(0xFFC2185B);
  static const primaryDeep = Color(0xFF880E4F);
  static const secondaryDark = Color(0xFF311B22);
  static const surfaceDark = Color(0xFF1C1218);
  static const onSurfaceDark = Color(0xFFF9E4EC);
  static const accentGoldDark = Color(0xFFC8A96A);
  static const buttonNumberDark = Color(0xFF2A1520);
  static const buttonOperatorDark = Color(0xFF6D2040);
  static const buttonSpecialDark = Color(0xFF4A1030);
  static const displayExpressionDark = Color(0xFF9E7080);
}

ThemeData get lightTheme {
  final base = ThemeData.light(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CherryBlossomColors.primary,
      brightness: Brightness.light,
      primary: CherryBlossomColors.primaryDark,
      secondary: CherryBlossomColors.secondary,
      surface: CherryBlossomColors.surface,
      onSurface: CherryBlossomColors.onSurface,
    ),
    scaffoldBackgroundColor: CherryBlossomColors.surface,
    textTheme: GoogleFonts.nunitoTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.nunito(
        fontSize: 56,
        fontWeight: FontWeight.w700,
        color: CherryBlossomColors.primaryDark,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: CherryBlossomColors.displayExpression,
      ),
      labelLarge: GoogleFonts.nunito(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: CherryBlossomColors.onSurface,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: CherryBlossomColors.primaryDark),
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: CherryBlossomColors.primaryDark,
      ),
    ),
  );
}

ThemeData get darkTheme {
  final base = ThemeData.dark(useMaterial3: true);
  return base.copyWith(
    colorScheme: ColorScheme.fromSeed(
      seedColor: CherryBlossomColors.primaryDarkMode,
      brightness: Brightness.dark,
      primary: CherryBlossomColors.primaryDarkMode,
      secondary: CherryBlossomColors.secondaryDark,
      surface: CherryBlossomColors.surfaceDark,
      onSurface: CherryBlossomColors.onSurfaceDark,
    ),
    scaffoldBackgroundColor: CherryBlossomColors.surfaceDark,
    textTheme: GoogleFonts.nunitoTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.nunito(
        fontSize: 56,
        fontWeight: FontWeight.w700,
        color: CherryBlossomColors.primaryDarkMode,
      ),
      bodyMedium: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        color: CherryBlossomColors.displayExpressionDark,
      ),
      labelLarge: GoogleFonts.nunito(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: CherryBlossomColors.onSurfaceDark,
      ),
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      iconTheme: const IconThemeData(color: CherryBlossomColors.primaryDarkMode),
      titleTextStyle: GoogleFonts.nunito(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: CherryBlossomColors.primaryDarkMode,
      ),
    ),
  );
}
