import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../notifications/notification_service.dart'
    show blockAlarmEnabledGlobal;

/// App-level settings with persistence: theme, locale, calendar, profile, onboarding.
class AppSettings extends ChangeNotifier {
  static const _keyTheme = 'settings.themeMode';
  static const _keyLocale = 'settings.locale';
  static const _keyName = 'settings.userName';
  static const _keyOnboarded = 'settings.onboarded';
  static const _keyCalendar = 'settings.calendarType';
  static const _keySeedColor = 'settings.seedColor';
  static const _keyNotifications = 'settings.notificationsEnabled';
  static const _keyBlockAlarm = 'settings.blockAlarmEnabled';
  static const _keyAppLock = 'settings.appLockEnabled';
  static const _keyBiometricLock = 'settings.biometricLockEnabled';
  static const _keyLockPin = 'settings.lockPin';

  final SharedPreferences _prefs;

  AppSettings(this._prefs);

  /// Master switch for all local notifications (default on).
  bool get notificationsEnabled => _prefs.getBool(_keyNotifications) ?? true;

  Future<void> setNotificationsEnabled(bool value) async {
    await _prefs.setBool(_keyNotifications, value);
    notifyListeners();
  }

  /// Whether end-of-block notifications play a loud alarm sound (default on).
  bool get blockAlarmEnabled => _prefs.getBool(_keyBlockAlarm) ?? true;

  Future<void> setBlockAlarmEnabled(bool value) async {
    await _prefs.setBool(_keyBlockAlarm, value);
    blockAlarmEnabledGlobal = value; // sync with notification_service
    notifyListeners();
  }

  /// App lock master switch (default off).
  bool get appLockEnabled => _prefs.getBool(_keyAppLock) ?? false;

  Future<void> setAppLockEnabled(bool value) async {
    await _prefs.setBool(_keyAppLock, value);
    if (value && !_prefs.containsKey(_keyLockPin)) {
      await _prefs.setString(_keyLockPin, _hashPin('0000'));
    }
    notifyListeners();
  }

  /// Whether biometric (fingerprint/face) is used for unlocking (default true).
  bool get biometricLockEnabled => _prefs.getBool(_keyBiometricLock) ?? true;

  Future<void> setBiometricLockEnabled(bool value) async {
    await _prefs.setBool(_keyBiometricLock, value);
    notifyListeners();
  }

  String get lockPinHash => _prefs.getString(_keyLockPin) ?? _hashPin('0000');

  Future<void> setLockPin(String pin) async {
    await _prefs.setString(_keyLockPin, _hashPin(pin));
    notifyListeners();
  }

  bool verifyLockPin(String pin) => lockPinHash == _hashPin(pin);

  static String _hashPin(String pin) {
    final bytes = utf8.encode(pin);
    return sha256.convert(bytes).toString();
  }

  /// Brand color seed (ARGB). Defaults to the ZedPlan blue.
  int get seedColor => _prefs.getInt(_keySeedColor) ?? 0xFF3C51C2;

  Future<void> setSeedColor(int argb) async {
    await _prefs.setInt(_keySeedColor, argb);
    notifyListeners();
  }

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

  Future<void> completeOnboarding(
      {required String name, required ThemeMode theme}) async {
    await _prefs.setString(_keyName, name.trim());
    await _prefs.setString(_keyTheme, theme.name);
    await _prefs.setBool(_keyOnboarded, true);
    notifyListeners();
  }
}
