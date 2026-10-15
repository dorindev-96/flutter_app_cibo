import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../constants/theme_constants.dart';

part 'theme_state.dart';

/// Cubit responsible for managing application theme state
///
/// Handles theme mode changes and provides the current theme mode
/// to the UI layer through state emissions.
class ThemeCubit extends Cubit<ThemeState> {
  /// Private constructor for internal use
  ThemeCubit._(ThemeMode initialMode) : super(ThemeReady(initialMode));

  /// Creates a ThemeCubit with the persisted theme mode loaded from storage
  ///
  /// This factory method ensures SharedPreferences is accessed after
  /// Flutter bindings are initialized.
  static Future<ThemeCubit> create() async {
    final themeMode = await _loadThemeMode();
    return ThemeCubit._(themeMode);
  }

  /// Returns the theme mode chosen by the user, including [ThemeMode.system]
  ThemeMode get selectedMode => switch (state) {
    ThemeReady(themeMode: final themeMode) => themeMode,
    _ => defaultThemeMode,
  };

  /// Sets the theme mode to the specified [mode]
  ///
  /// Emits a new [ThemeReady] state with the updated theme mode.
  ///
  /// Parameters:
  ///   - [mode]: The theme mode to set
  void setThemeMode(ThemeMode mode) {
    _saveThemeMode(mode);
    emit(ThemeReady(mode));
  }

  void _saveThemeMode(ThemeMode mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(themeModeKey, mode.index);
  }

  static Future<ThemeMode> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    final index = prefs.getInt(themeModeKey) ?? defaultThemeMode.index;

    if (index < 0 || index >= ThemeMode.values.length) {
      return defaultThemeMode;
    }
    return ThemeMode.values[index];
  }
}
