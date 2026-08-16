import 'package:flutter/material.dart';

/// Color tokens from /ui/aura/DESIGN.md.
///
/// Brand and status colors are theme-independent constants. Neutral/surface
/// tokens resolve against the current brightness, which the app root sets via
/// [AppColors.brightness] in the MaterialApp builder — screens keep using
/// `AppColors.surface` etc. and get correct dark values for free.
class AppColors {
  AppColors._();

  // ---------- brightness resolution ----------

  static Brightness _brightness = Brightness.light;

  /// Set once per build by the app root; defaults to light.
  static set brightness(Brightness b) => _brightness = b;

  static bool get _dark => _brightness == Brightness.dark;

  // ---------- Primary & Tints (theme-independent) ----------

  static const Color primary = Color(0xFF3C51C2);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color primaryContainer = Color(0xFF566BDC);
  static const Color onPrimaryContainer = Color(0xFFFFFBFF);
  static const Color primaryFixed = Color(0xFFDEE0FF);
  static const Color onPrimaryFixed = Color(0xFF00105C);
  static const Color primaryFixedDim = Color(0xFFBAC3FF);
  static const Color surfaceTint = Color(0xFF3F53C4);

  // ---------- Secondary & Neutral accents ----------

  static const Color secondary = Color(0xFF5F5E60);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color secondaryContainer = Color(0xFFE2DFE1);
  static const Color onSecondaryContainer = Color(0xFF636264);

  // ---------- Tertiary ----------

  static const Color tertiary = Color(0xFF5A5C5E);
  static const Color onTertiary = Color(0xFFFFFFFF);
  static const Color tertiaryContainer = Color(0xFF737576);

  // ---------- Status & Semantic ----------

  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFBA1A1A);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF93000A);

  // ---------- Light palette (raw constants) ----------

  static const Color _lightBackground = Color(0xFFF7F9FF);
  static const Color _lightOnBackground = Color(0xFF0D1D2B);
  static const Color _lightSurface = Color(0xFFF7F9FF);
  static const Color _lightSurfaceDim = Color(0xFFCBDCEF);
  static const Color _lightSurfaceContainerLowest = Color(0xFFFFFFFF);
  static const Color _lightSurfaceContainerLow = Color(0xFFEDF4FF);
  static const Color _lightSurfaceContainer = Color(0xFFE3EFFF);
  static const Color _lightSurfaceContainerHigh = Color(0xFFD9EAFE);
  static const Color _lightSurfaceContainerHighest = Color(0xFFD4E4F8);
  static const Color _lightOnSurface = Color(0xFF0D1D2B);
  static const Color _lightOnSurfaceVariant = Color(0xFF454653);
  static const Color _lightInverseSurface = Color(0xFF223241);
  static const Color _lightOutline = Color(0xFF757685);
  static const Color _lightOutlineVariant = Color(0xFFC5C5D5);

  // ---------- Dark palette (Obsidian variant, raw constants) ----------

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

  // ---------- Resolved surface tokens ----------

  static Color get background => _dark ? darkBackground : _lightBackground;
  static Color get onBackground => _dark ? darkOnBackground : _lightOnBackground;
  static Color get surface => _dark ? darkSurface : _lightSurface;
  static Color get surfaceDim => _dark ? darkSurfaceContainer : _lightSurfaceDim;
  static Color get surfaceContainerLowest =>
      _dark ? darkSurfaceContainerLow : _lightSurfaceContainerLowest;
  static Color get surfaceContainerLow =>
      _dark ? darkSurfaceContainerLow : _lightSurfaceContainerLow;
  static Color get surfaceContainer => _dark ? darkSurfaceContainer : _lightSurfaceContainer;
  static Color get surfaceContainerHigh =>
      _dark ? darkSurfaceContainerHigh : _lightSurfaceContainerHigh;
  static Color get surfaceContainerHighest =>
      _dark ? darkSurfaceContainerHigh : _lightSurfaceContainerHighest;
  static Color get onSurface => _dark ? darkOnSurface : _lightOnSurface;
  static Color get onSurfaceVariant => _dark ? darkOnSurfaceVariant : _lightOnSurfaceVariant;
  static Color get inverseSurface => _dark ? _lightSurface : _lightInverseSurface;
  static Color get outline => _dark ? darkOutline : _lightOutline;
  static Color get outlineVariant => _dark ? darkOutlineVariant : _lightOutlineVariant;

  // ---------- Glassmorphic overlay & borders ----------

  static Color get glassBackground => _dark ? glassBackgroundDark : glassBackgroundLight;
  static Color get glassBorder => _dark ? glassBorderDark : glassBorderLight;
  static const Color glassBackgroundLight = Color(0xB3FFFFFF); // 70% white
  static const Color glassBorderLight = Color(0x66FFFFFF); // 40% white border
  static const Color glassBackgroundDark = Color(0xB316171B);
  static const Color glassBorderDark = Color(0x33566BDC);
}
