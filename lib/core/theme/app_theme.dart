
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFFF8F6F1);
  static const surface = Color(0xFFFFFFFF);
  static const navy = Color(0xFF10243B);
  static const mutedText = Color(0xFF64748B);
  static const sage = Color(0xFFDDECE0);
  static const sky = Color(0xFFDCEBFA);
  static const peach = Color(0xFFF9DED0);
  static const sand = Color(0xFFF7E7D1);
  static const accent = Color(0xFF4E8B73);
}

class AppTypography {
  static TextStyle get hero => GoogleFonts.nunito(
    fontSize: 38,
    fontWeight: FontWeight.w800,
    height: 1.1,
    color: AppColors.navy,
  );

  static TextStyle get section => GoogleFonts.oswald(
    fontSize: 24,
    fontWeight: FontWeight.w700,
    color: AppColors.navy,
  );

  static TextStyle get body => GoogleFonts.dmSans(
    fontSize: 14,
    color: AppColors.navy,
  );

  static TextStyle get caption => GoogleFonts.dmSans(
    fontSize: 12,
    color: AppColors.mutedText,
  );
}

class AppTheme {
  static ThemeData get light {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.navy,
      brightness: Brightness.light,
      surface: AppColors.surface,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      textTheme: ThemeData.light().textTheme,
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.navy,
        elevation: 0,
        scrolledUnderElevation: 0,
      ),
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.sage,
        height: 72,
      ),
    );
  }
}
