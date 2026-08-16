import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

/// Typography definitions matching /ui/aura/DESIGN.md
class AppTypography {
  static const String fontFa = 'Vazirmatn';
  static const String fontEn = 'Inter';

  static TextStyle displayData({Color? color, String font = fontFa}) {
    return GoogleFonts.getFont(
      font,
      fontSize: 48,
      height: 56 / 48,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.96,
      color: color ?? AppColors.onSurface,
    );
  }

  static TextStyle headlineLg({Color? color, String font = fontFa}) {
    return GoogleFonts.getFont(
      font,
      fontSize: 32,
      height: 40 / 32,
      fontWeight: FontWeight.w600,
      letterSpacing: -0.32,
      color: color ?? AppColors.onSurface,
    );
  }

  static TextStyle headlineLgMobile({Color? color, String font = fontFa}) {
    return GoogleFonts.getFont(
      font,
      fontSize: 24,
      height: 32 / 24,
      fontWeight: FontWeight.w600,
      color: color ?? AppColors.onSurface,
    );
  }

  static TextStyle headlineMd({Color? color, String font = fontFa}) {
    return GoogleFonts.getFont(
      font,
      fontSize: 20,
      height: 28 / 20,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.onSurface,
    );
  }

  static TextStyle bodyLg({Color? color, String font = fontFa}) {
    return GoogleFonts.getFont(
      font,
      fontSize: 16,
      height: 24 / 16,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.onSurface,
    );
  }

  static TextStyle bodySm({Color? color, String font = fontFa}) {
    return GoogleFonts.getFont(
      font,
      fontSize: 14,
      height: 20 / 14,
      fontWeight: FontWeight.w400,
      color: color ?? AppColors.onSurfaceVariant,
    );
  }

  static TextStyle labelCaps({Color? color, String font = fontFa}) {
    return GoogleFonts.getFont(
      font,
      fontSize: 12,
      height: 16 / 12,
      fontWeight: FontWeight.w600,
      letterSpacing: 0.6,
      color: color ?? AppColors.onSurfaceVariant,
    );
  }

  static TextStyle numericMd({Color? color, String font = fontFa}) {
    return GoogleFonts.getFont(
      font,
      fontSize: 18,
      height: 24 / 18,
      fontWeight: FontWeight.w500,
      color: color ?? AppColors.primary,
    );
  }
}
