import 'package:flutter/material.dart';
import 'package:flutter_ship_app/src/utils/shared_preferences_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'app_theme_mode.g.dart';

/// A notifier used to read and write the themeMode to SharedPreferences
@riverpod
class AppThemeModeNotifier extends _$AppThemeModeNotifier {
  static const key = 'app_theme_mode';

  SharedPreferences get _sharedPreferences =>
      ref.watch(sharedPreferencesProvider).requireValue;

  @override
  ThemeMode build() {
    final themeModeStr = _sharedPreferences.getString(key);
    return switch (themeModeStr) {
      'system' => ThemeMode.system,
      'light' => ThemeMode.light,
      'dark' => ThemeMode.dark,
      _ => ThemeMode.system
    };
  }

  void setThemeMode(ThemeMode mode) {
    _sharedPreferences.setString(key, mode.name);
    ref.invalidateSelf();
  }
}
