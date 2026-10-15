import 'dart:io';

import 'package:cibo/constants/app_constants.dart';
import 'package:cibo/l10n/app_localizations.dart';
import 'package:cibo/main.dart';
import 'package:cibo/screens/aiuto_screen.dart';
import 'package:cibo/screens/guida_iniziale_screen.dart';
import 'package:cibo/services/immagini_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  setUpAll(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // The saved containers example resolves photos through ImmaginiService.
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(
          const MethodChannel('plugins.flutter.io/path_provider'),
          (_) async => Directory.systemTemp.path,
        );
    immaginiService = await ImmaginiService.create();
  });

  setUp(() => SharedPreferences.setMockInitialValues({}));

  Widget app(GoRouter router, {Locale locale = const Locale('it')}) =>
      ScreenUtilInit(
        designSize: appDesignSize,
        builder: (_, _) => MaterialApp.router(
          routerConfig: router,
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
        ),
      );

  GoRouter router({String initialLocation = '/benvenuto'}) => GoRouter(
    initialLocation: initialLocation,
    routes: [
      GoRoute(
        path: '/',
        builder: (context, _) => Scaffold(
          body: TextButton(
            onPressed: () => context.push('/benvenuto'),
            child: const Text('frigo'),
          ),
        ),
      ),
      GoRoute(
        path: '/benvenuto',
        builder: (_, _) => const GuidaInizialeScreen(),
      ),
    ],
  );

  Future<bool?> guidaVista() async =>
      (await SharedPreferences.getInstance()).getBool(guidaVistaKey);

  group('GuidaInizialeScreen', () {
    testWidgets('goes through all the pages and opens the fridge', (
      tester,
    ) async {
      await tester.pumpWidget(app(router()));
      await tester.pumpAndSettle();

      expect(find.text('Ti diamo il benvenuto in Cibo'), findsOneWidget);
      for (final titolo in [
        'Pesa, al resto pensa Cibo',
        'Gnam!',
        'Sempre fresco',
        'I tuoi contenitori',
      ]) {
        await tester.tap(find.text('Avanti'));
        await tester.pumpAndSettle();
        expect(find.text(titolo), findsOneWidget);
      }

      // Last page: "Inizia" instead of "Avanti", no "Salta".
      expect(find.text('Avanti'), findsNothing);
      expect(find.text('Salta').hitTestable(), findsNothing);

      await tester.tap(find.text('Inizia'));
      await tester.pumpAndSettle();

      expect(find.text('frigo'), findsOneWidget);
      expect(await guidaVista(), isTrue);
    });

    testWidgets('can be skipped', (tester) async {
      await tester.pumpWidget(app(router()));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Salta'));
      await tester.pumpAndSettle();

      expect(find.text('frigo'), findsOneWidget);
      expect(await guidaVista(), isTrue);
    });

    testWidgets('goes back when opened from another page', (tester) async {
      await tester.pumpWidget(app(router(initialLocation: '/')));
      await tester.pumpAndSettle();
      await tester.tap(find.text('frigo'));
      await tester.pumpAndSettle();
      expect(find.byType(GuidaInizialeScreen), findsOneWidget);

      await tester.tap(find.text('Salta'));
      await tester.pumpAndSettle();

      expect(find.byType(GuidaInizialeScreen), findsNothing);
      expect(find.text('frigo'), findsOneWidget);
    });
  });

  for (final locale in AppLocalizations.supportedLocales) {
    testWidgets('help page shows every section in $locale', (tester) async {
      final helpRouter = GoRouter(
        routes: [GoRoute(path: '/', builder: (_, _) => const AiutoScreen())],
      );
      await tester.pumpWidget(app(helpRouter, locale: locale));
      await tester.pumpAndSettle();

      final appLoc = await AppLocalizations.delegate.load(locale);
      for (final titolo in [
        appLoc.guideCalcTitle,
        appLoc.guideGnamTitle,
        appLoc.guideFreshTitle,
        appLoc.guideSetsTitle,
      ]) {
        await tester.scrollUntilVisible(find.text(titolo), 200);
        expect(find.text(titolo), findsOneWidget);
      }
      await tester.scrollUntilVisible(find.text(appLoc.help_thanks), 200);
    });
  }
}
