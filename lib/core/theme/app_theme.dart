import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  AppColors._();

  // Base
  static const Color dark = Color(0xFF39413D);
  static const Color white = Color(0xFFFFFFFF);
  static const Color orange = Color(0xFFFAB526);
  static const Color accentGreen = Color(0xFF9ACA3E);
  static const Color red = Color(0xFFFF5C5C);

  // Gray
  static const Color gray100 = Color(0xFFDEDDDD);
  static const Color gray200 = Color(0xFF9B9B9B);
  static const Color gray300 = Color(0xFFABABAB);
  static const Color gray400 = Color(0xFFE2E9E2);

  // Text
  static const Color textPrimary = Color(0xFF151515);
  static const Color textSecondary = Color(0xFF5A5959);

  // Neutral (background)
  static const Color neutral100 = Color(0xFFF5F5F5);
  static const Color neutral200 = Color(0xFFB9B8B8);
  static const Color background = neutral100;

  // Badge / Status
  static const Color badgeBelumBayar = orange;
  static const Color badgeBerlangsung = accentGreen;
  static const Color badgeSelesai = dark;
  static const Color badgeBatal = red;
}

class AppTextStyles {
  AppTextStyles._();

  // ── XS — 10px ─────────────────────────────────────────────────────────────
  static TextStyle textXSLight = GoogleFonts.outfit(
    fontSize: 10,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
  );
  static TextStyle textXSRegular = GoogleFonts.outfit(
    fontSize: 10,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static TextStyle textXSMedium = GoogleFonts.outfit(
    fontSize: 10,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );

  // ── S — 12px ──────────────────────────────────────────────────────────────
  static TextStyle textSLight = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
  );
  static TextStyle textSRegular = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static TextStyle textSMedium = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static TextStyle textSSemiBold = GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ── M — 14px ──────────────────────────────────────────────────────────────
  static TextStyle textMLight = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w300,
    color: AppColors.textPrimary,
  );
  static TextStyle textMRegular = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static TextStyle textMMedium = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static TextStyle textMSemiBold = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  static TextStyle textMBold = GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  // ── L — 16px ──────────────────────────────────────────────────────────────
  static TextStyle textLRegular = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static TextStyle textLMedium = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static TextStyle textLSemiBold = GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ── XL — 18px ─────────────────────────────────────────────────────────────
  static TextStyle textXLRegular = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w400,
    color: AppColors.textPrimary,
  );
  static TextStyle textXLMedium = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static TextStyle textXLSemiBold = GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ── 2XL — 24px ────────────────────────────────────────────────────────────
  static TextStyle text2XLMedium = GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
  );
  static TextStyle text2XLSemiBold = GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ── 3XL — 28px ────────────────────────────────────────────────────────────
  static TextStyle text3XLSemiBold = GoogleFonts.outfit(
    fontSize: 28,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // ── Backwards-compatible aliases ──────────────────────────────────────────
  static TextStyle get heading1 =>
      textXLMedium.copyWith(color: AppColors.white);
  static TextStyle get heading2 => textXLSemiBold;
  static TextStyle get heading3 => textXLMedium;
  static TextStyle get body =>
      textSRegular.copyWith(color: AppColors.textSecondary);
  static TextStyle get bodySmall =>
      textXSLight.copyWith(color: AppColors.white);
  static TextStyle get label =>
      textLMedium.copyWith(color: AppColors.white);
  static TextStyle get caption =>
      textSRegular.copyWith(color: AppColors.textSecondary);
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
