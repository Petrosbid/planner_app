import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// App-level settings with persistence: theme, locale, calendar, profile, onboarding.
class AppSettings extends ChangeNotifier {
  static const _keyTheme = 'settings.themeMode';
  static const _keyLocale = 'settings.locale';
  static const _keyName = 'settings.userName';
  static const _keyOnboarded = 'settings.onboarded';
  static const _keyCalendar = 'settings.calendarType';

  final SharedPreferences _prefs;

  AppSettings(this._prefs);

  /// Which calendar system dates are displayed in: 'jalali' or 'gregorian'.
  /// Stored dates are always absolute DateTime; only presentation changes.
  bool get useJalali => _prefs.getString(_keyCalendar) != 'gregorian';

  Future<void> setUseJalali(bool value) async {
    await _prefs.setString(_keyCalendar, value ? 'jalali' : 'gregorian');
    notifyListeners();
  }

  ThemeMode get themeMode {
    switch (_prefs.getString(_keyTheme)) {
      case 'dark':
        return ThemeMode.dark;
      case 'light':
        return ThemeMode.light;
      default:
        return ThemeMode.system;
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    await _prefs.setString(_keyTheme, mode.name);
    notifyListeners();
  }

  Locale get locale {
    final code = _prefs.getString(_keyLocale);
    return code == 'en' ? const Locale('en') : const Locale('fa');
  }

  Future<void> setLocale(Locale value) async {
    await _prefs.setString(_keyLocale, value.languageCode);
    notifyListeners();
  }

  String get userName => _prefs.getString(_keyName) ?? '';

  Future<void> setUserName(String name) async {
    await _prefs.setString(_keyName, name.trim());
    notifyListeners();
  }

  bool get onboarded => _prefs.getBool(_keyOnboarded) ?? false;

  Future<void> completeOnboarding({required String name, required ThemeMode theme}) async {
    await _prefs.setString(_keyName, name.trim());
    await _prefs.setString(_keyTheme, theme.name);
    await _prefs.setBool(_keyOnboarded, true);
    notifyListeners();
  }
}
