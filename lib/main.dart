/// Main entry point for the Flutter application
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/app_router.dart';
import 'constants/app_constants.dart';
import 'theme/theme.dart';
import 'cubit/freschezza_cubit/freschezza_cubit.dart';
import 'cubit/theme_cubit/theme_cubit.dart';
import 'l10n/app_localizations.dart';
import 'repositories/set_contenitori_repository.dart';
import 'services/immagini_service.dart';
import 'services/objectbox.dart';

/// Global instance of ObjectBox for database operations
late ObjectBox objectBox;

/// Global instance of ThemeCubit
late ThemeCubit themeCubit;

/// Global instance of FreschezzaCubit
late FreschezzaCubit freschezzaCubit;

/// Global instance of the service storing the container set photos
late ImmaginiService immaginiService;

/// Whether the introductory guide has to be shown at startup (first launch)
late bool mostraGuidaIniziale;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  objectBox = await ObjectBox.create();
  themeCubit = await ThemeCubit.create();
  freschezzaCubit = await FreschezzaCubit.create();
  immaginiService = await ImmaginiService.create();
  await immaginiService.migraPercorsiAssoluti(SetContenitoriRepository());
  final prefs = await SharedPreferences.getInstance();
  mostraGuidaIniziale = !(prefs.getBool(guidaVistaKey) ?? false);

  runApp(const MainApp());
}

/// Root widget of the application
///
/// Initializes screen utilities, sets up BLoC providers, and configures
/// localization and theme support.
class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: appDesignSize,
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider.value(value: themeCubit),
          BlocProvider.value(value: freschezzaCubit),
        ],
        child: BlocBuilder<ThemeCubit, ThemeState>(
          builder: (_, state) => switch (state) {
            ThemeReady(themeMode: final themeMode) => MaterialApp.router(
              routerConfig: appRouter,
              themeMode: themeMode,
              theme: lightTheme,
              darkTheme: darkTheme,
              localizationsDelegates: [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              debugShowCheckedModeBanner: false,
            ),
            _ => const SizedBox(),
          },
        ),
      ),
    );
  }
}
