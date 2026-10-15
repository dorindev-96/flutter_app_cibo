import 'package:flutter/material.dart';

import '../l10n/app_localizations.dart';

/// Shows a dialog to choose the app theme: system, light or dark.
///
/// Returns the chosen [ThemeMode], or `null` if the dialog is dismissed.
Future<ThemeMode?> showSelezionaTemaDialog(
  BuildContext context, {
  required ThemeMode selezionato,
}) {
  final appLoc = AppLocalizations.of(context)!;
  final colorScheme = Theme.of(context).colorScheme;

  return showDialog<ThemeMode>(
    context: context,
    builder: (context) => SimpleDialog(
      title: Text(appLoc.settings_theme),
      children: [
        for (final mode in ThemeMode.values)
          ListTile(
            leading: Icon(_icona(mode)),
            title: Text(nomeTema(appLoc, mode)),
            trailing: mode == selezionato
                ? Icon(Icons.check, color: colorScheme.primary)
                : null,
            selected: mode == selezionato,
            onTap: () => Navigator.of(context).pop(mode),
          ),
      ],
    ),
  );
}

/// Returns the localized name of the theme [mode].
String nomeTema(AppLocalizations appLoc, ThemeMode mode) => switch (mode) {
  ThemeMode.system => appLoc.settings_theme_system,
  ThemeMode.light => appLoc.settings_theme_light,
  ThemeMode.dark => appLoc.settings_theme_dark,
};

IconData _icona(ThemeMode mode) => switch (mode) {
  ThemeMode.system => Icons.brightness_auto_outlined,
  ThemeMode.light => Icons.light_mode_outlined,
  ThemeMode.dark => Icons.dark_mode_outlined,
};
