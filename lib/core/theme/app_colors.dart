import 'package:flutter/material.dart';

/// Exact color tokens defined in /ui/aura/DESIGN.md
class AppColors {
  // Primary & Tints
  static const Color primary = Color(0xFF3C51C2);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF566BDC);
  static const Color onPrimaryContainer = Color(0xFFFFFBFF);
  static const Color primaryFixed = Color(0xFFDEE0FF);
  static const Color onPrimaryFixed = Color(0xFF00105C);
  static const Color primaryFixedDim = Color(0xFFBAC3FF);
  static const Color surfaceTint = Color(0xFF3F53C4);

  // Secondary & Neutral
  static const Color secondary = Color(0xFF5F5E60);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE2DFE1);
  static const Color onSecondaryContainer = Color(0xFF636264);

  // Tertiary
  static const Color tertiary = Color(0xFF5A5C5E);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF737576);

  // Status & Semantic
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // Light Theme Surfaces
  static const Color background = Color(0xFFF7F9FF);
  static const Color onBackground = Color(0xFF0D1D2B);
  static const Color surface = Color(0xFFF7F9FF);
  static const Color surfaceDim = Color(0xFFCBDCEF);
  static const Color surfaceBright = Color(0xFFF7F9FF);
  static const Color surfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color surfaceContainerLow = Color(0xFFEDF4FF);
  static const Color surfaceContainer = Color(0xFFE3EFFF);
  static const Color surfaceContainerHigh = Color(0xFFD9EAFE);
  static const Color surfaceContainerHighest = Color(0xFFD4E4F8);
  static const Color onSurface = Color(0xFF0D1D2B);
  static const Color onSurfaceVariant = Color(0xFF454653);
  static const Color inverseSurface = Color(0xFF223241);
  static const Color inverseOnSurface = Color(0xFFE8F2FF);
  static const Color outline = Color(0xFF757685);
  static const Color outlineVariant = Color(0xFFC5C5D5);

  // Dark Theme Surfaces (Obsidian variant)
  static const Color darkBackground = Color(0xFF0D0D0E);
  static const Color darkOnBackground = Color(0xFFF7F9FF);
  static const Color darkSurface = Color(0xFF16171B);
  static const Color darkSurfaceContainerLow = Color(0xFF1A1C22);
  static const Color darkSurfaceContainer = Color(0xFF22252E);
  static const Color darkSurfaceContainerHigh = Color(0xFF2B2F3B);
  static const Color darkOnSurface = Color(0xFFF7F9FF);
  static const Color darkOnSurfaceVariant = Color(0xFFA1A5B7);
  static const Color darkOutline = Color(0xFF4A4E5E);
  static const Color darkOutlineVariant = Color(0xFF2E3240);

  // Glassmorphic Overlay & Borders
  static const Color glassBackgroundLight = Color(0xB3FFFFFF); // 70% white
  static const Color glassBorderLight = Color(0x66FFFFFF); // 40% white border
  static const Color glassBackgroundDark = Color(0xB316171B);
  static const Color glassBorderDark = Color(0x33566BDC);
}
