import 'package:cibo/l10n/app_localizations.dart';
import 'package:cibo/models/freschezza.dart';
import 'package:cibo/widgets/contenitore_frigo_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> pumpCard(
    WidgetTester tester, {
    required Locale locale,
    required int giorniFa,
  }) async {
    final oggi = DateTime(2026, 10, 14);
    final dataInserimento = oggi.subtract(Duration(days: giorniFa));

    await tester.pumpWidget(
      ScreenUtilInit(
        designSize: const Size(390, 844),
        builder: (_, _) => MaterialApp(
          locale: locale,
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ContenitoreFrigoWidget(
              nomeContenitore: 'Ceci',
              pesoPorzione: 133.333,
              porzioniDisponibili: 3,
              dataInserimento: dataInserimento,
              freschezza: Freschezza.calcola(
                dataCaricamento: dataInserimento,
                durataGiorni: 3,
                oggi: oggi,
              ),
            ),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('shows weights, date and freshness in Italian', (tester) async {
    await pumpCard(tester, locale: const Locale('it'), giorniFa: 0);

    expect(find.text('Porzione: 133,33 g'), findsOneWidget);
    expect(find.text('Data Caricamento: 14/10/2026'), findsOneWidget);
    expect(find.text('Oggi'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
  });

  testWidgets('shows weights, date and freshness in English', (tester) async {
    await pumpCard(tester, locale: const Locale('en'), giorniFa: 2);

    expect(find.text('Portion: 133.33 g'), findsOneWidget);
    expect(find.text('Upload Date: 10/12/2026'), findsOneWidget);
    expect(find.text('2 days ago'), findsOneWidget);
    expect(find.byIcon(Icons.schedule), findsOneWidget);
  });

  testWidgets('marks expired food', (tester) async {
    await pumpCard(tester, locale: const Locale('it'), giorniFa: 5);

    expect(find.text('5 giorni fa'), findsOneWidget);
    expect(find.byIcon(Icons.error_outline), findsOneWidget);
    expect(find.byTooltip('Scaduto'), findsOneWidget);
  });
}
