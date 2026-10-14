import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../l10n/app_localizations.dart';
import '../cubit/freschezza_cubit/freschezza_cubit.dart';
import '../cubit/theme_cubit/theme_cubit.dart';
import '../widgets/durata_freschezza_dialog.dart';
import '../widgets/seleziona_tema_dialog.dart';

/// Settings screen (impostazioni): theme, food shelf life and help.
class ImpostazioniScreen extends StatelessWidget {
  const ImpostazioniScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final localizations = AppLocalizations.of(context)!;
    final selectedThemeMode = context.watch<ThemeCubit>().selectedMode;
    final durate = context.watch<FreschezzaCubit>().state;
    final valueStyle = theme.textTheme.bodySmall?.copyWith(
      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
    );

    Widget trailing(String value) => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(value, style: valueStyle),
        SizedBox(width: 8.w),
        Icon(Icons.chevron_right, size: 24.w, color: theme.colorScheme.outline),
      ],
    );

    return Scaffold(
      appBar: AppBar(title: Text(localizations.settings_title)),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              children: [
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.palette_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        title: Text(localizations.settings_theme),
                        onTap: () => _selectTheme(context, selectedThemeMode),
                        trailing: trailing(
                          nomeTema(localizations, selectedThemeMode),
                        ),
                      ),
                      Divider(indent: 56.w),
                      ListTile(
                        leading: Icon(
                          Icons.help_outline,
                          color: theme.colorScheme.primary,
                        ),
                        title: Text(localizations.settings_help),
                        onTap: () => _handleHelp(context),
                        trailing: Icon(
                          Icons.chevron_right,
                          size: 24.w,
                          color: theme.colorScheme.outline,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8.h),
                Card(
                  child: Column(
                    children: [
                      ListTile(
                        leading: Icon(
                          Icons.kitchen_outlined,
                          color: theme.colorScheme.primary,
                        ),
                        title: Text(localizations.settings_freshness_fridge),
                        onTap: () => _setShelfLife(context, nelFreezer: false),
                        trailing: trailing(
                          localizations.freshnessDays(durate.giorniFrigo),
                        ),
                      ),
                      Divider(indent: 56.w),
                      ListTile(
                        leading: Icon(
                          Icons.ac_unit,
                          color: theme.colorScheme.primary,
                        ),
                        title: Text(localizations.settings_freshness_freezer),
                        onTap: () => _setShelfLife(context, nelFreezer: true),
                        trailing: trailing(
                          localizations.freshnessDays(durate.giorniFreezer),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 8.h,
                  ),
                  child: Text(
                    localizations.settings_freshness_note,
                    style: valueStyle,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 24.h),
            child: Center(
              child: Text(
                'Copyright © 2026 Dorin Tverdohleb',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectTheme(BuildContext context, ThemeMode selected) async {
    final themeCubit = context.read<ThemeCubit>();
    final mode = await showSelezionaTemaDialog(context, selezionato: selected);
    if (mode != null) themeCubit.setThemeMode(mode);
  }

  Future<void> _setShelfLife(
    BuildContext context, {
    required bool nelFreezer,
  }) async {
    final localizations = AppLocalizations.of(context)!;
    final freschezzaCubit = context.read<FreschezzaCubit>();
    final giorni = await showDurataFreschezzaDialog(
      context,
      titolo: nelFreezer
          ? localizations.settings_freshness_freezer
          : localizations.settings_freshness_fridge,
      giorni: freschezzaCubit.state.giorniPer(nelFreezer: nelFreezer),
    );
    if (giorni == null) return;
    if (nelFreezer) {
      await freschezzaCubit.setGiorniFreezer(giorni);
    } else {
      await freschezzaCubit.setGiorniFrigo(giorni);
    }
  }

  _handleHelp(BuildContext context) {
    context.push('/impostazioni/aiuto');
  }
}
