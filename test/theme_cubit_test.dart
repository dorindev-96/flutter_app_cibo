import 'package:cibo/constants/theme_constants.dart';
import 'package:cibo/cubit/theme_cubit/theme_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUp(() => SharedPreferences.setMockInitialValues({}));

  test('follows the system theme by default', () async {
    final cubit = await ThemeCubit.create();

    expect(cubit.selectedMode, ThemeMode.system);
    expect(cubit.state, isA<ThemeReady>());
    await cubit.close();
  });

  test('loads the saved theme', () async {
    SharedPreferences.setMockInitialValues({
      themeModeKey: ThemeMode.dark.index,
    });

    final cubit = await ThemeCubit.create();

    expect(cubit.selectedMode, ThemeMode.dark);
    await cubit.close();
  });

  test('ignores an invalid saved theme', () async {
    for (final valore in [-1, ThemeMode.values.length]) {
      SharedPreferences.setMockInitialValues({themeModeKey: valore});

      final cubit = await ThemeCubit.create();

      expect(cubit.selectedMode, defaultThemeMode);
      await cubit.close();
    }
  });

  test('applies the chosen theme and keeps it at the next start', () async {
    final cubit = await ThemeCubit.create();

    cubit.setThemeMode(ThemeMode.light);

    expect(cubit.selectedMode, ThemeMode.light);
    expect(
      cubit.state,
      isA<ThemeReady>().having(
        (s) => s.themeMode,
        'themeMode',
        ThemeMode.light,
      ),
    );

    // The theme is saved in the background.
    await pumpEventQueue();
    final riavviato = await ThemeCubit.create();
    expect(riavviato.selectedMode, ThemeMode.light);

    await cubit.close();
    await riavviato.close();
  });
}
