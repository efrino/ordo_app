import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // Base
  static const Color dark = Color(0xFF334A34);
  static const Color white = Color(0xFFFFFFFF);
  static const Color background = Color(0xFFF5F5F5);

  // Accent
  static const Color accentGreen = Color(0xFF9ACA3E);
  static const Color red = Color(0xFFFF5C5C);

  // Gray
  static const Color gray100 = Color(0xFFDEDDDD);
  static const Color gray200 = Color(0xFF9B9B9B);
  static const Color gray300 = Color(0xFF7E7E7E);
  static const Color gray400 = Color(0xFF9E9E9E);
}

class AppTextStyles {
  AppTextStyles._();

  static TextStyle heading1 = GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static TextStyle heading2 = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.dark,
  );

  static TextStyle heading3 = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.dark,
  );

  static TextStyle body = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.gray300,
  );

  static TextStyle bodySmall = GoogleFonts.outfit(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: AppColors.white,
  );

  static TextStyle label = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.white,
  );

  static TextStyle caption = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.gray400,
  );
}

class AppTheme {
  AppTheme._();

  static ThemeData get theme => ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: AppColors.dark),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
        textTheme: GoogleFonts.outfitTextTheme(),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppColors.background,
          elevation: 0,
          scrolledUnderElevation: 0,
        ),
      );
}
