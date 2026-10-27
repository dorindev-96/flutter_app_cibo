/// Application routing configuration
library;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../main.dart';
import '../screens/guida_iniziale_screen.dart';
import '../screens/main_shell_screen.dart';
import '../screens/elenco_contenitori_frigo_screen.dart';
import '../screens/dettaglio_contenitore_frigo_screen.dart';
import '../screens/elenco_contenitori_screen.dart';
import '../screens/impostazioni_screen.dart';
import '../screens/aiuto_screen.dart';

import '../bloc/elenco_contenitori_frigo_screen/elenco_contenitori_frigo_screen_bloc.dart';
import '../bloc/elenco_contenitori_screen/elenco_contenitori_screen_bloc.dart';

/// Global navigator keys for each shell branch
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _fridgeNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'fridge');
final _containersNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'containers',
);
final _settingsNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'settings');

/// Application router configuration with tab-based navigation.
///
/// Uses [StatefulShellRoute.indexedStack] for a [NavigationBar] that
/// preserves each tab's navigation state independently.
///
/// At the first launch the app opens the introductory guide
/// ([mostraGuidaIniziale] is set in `main` before the router is first used).
final appRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: mostraGuidaIniziale ? '/benvenuto' : '/',
  routes: [
    // Introductory guide, outside the tabs
    GoRoute(
      path: '/benvenuto',
      builder: (context, state) => const GuidaInizialeScreen(),
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return MainShellScreen(navigationShell: navigationShell);
      },
      branches: [
        // Branch 0: Fridge (default)
        StatefulShellBranch(
          navigatorKey: _fridgeNavigatorKey,
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) {
                return BlocProvider(
                  create: (_) => ElencoContenitoriFrigoScreenBloc(),
                  child: const ElencoContenitoriFrigoScreen(),
                );
              },
              routes: [
                GoRoute(
                  path: 'dettaglio-contenitore-frigo/:idContenitore',
                  // A deep link with an invalid id opens the fridge.
                  redirect: (context, state) =>
                      int.tryParse(state.pathParameters['idContenitore']!) ==
                          null
                      ? '/'
                      : null,
                  builder: (context, state) {
                    final int idContenitore = int.parse(
                      state.pathParameters['idContenitore']!,
                    );
                    final bool isNew =
                        state.uri.queryParameters['isNew'] == 'true';
                    return DettaglioContenitoreFrigoScreen(
                      idContenitore: idContenitore,
                      isNew: isNew,
                    );
                  },
                ),
              ],
            ),
          ],
        ),

        // Branch 1: Container Sets
        StatefulShellBranch(
          navigatorKey: _containersNavigatorKey,
          routes: [
            GoRoute(
              path: '/contenitori',
              builder: (context, state) {
                return BlocProvider(
                  create: (_) => ElencoContenitoriScreenBloc(),
                  child: const ElencoContenitoriScreen(),
                );
              },
            ),
          ],
        ),

        // Branch 2: Settings
        StatefulShellBranch(
          navigatorKey: _settingsNavigatorKey,
          routes: [
            GoRoute(
              path: '/impostazioni',
              builder: (context, state) {
                return const ImpostazioniScreen();
              },
              routes: [
                GoRoute(
                  path: 'aiuto',
                  builder: (context, state) {
                    return const AiutoScreen();
                  },
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
