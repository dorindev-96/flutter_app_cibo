import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../l10n/app_localizations.dart';
import '../models/freschezza.dart';
import '../utils/formato.dart';
import 'contenitore_frigo_widget.dart';
import 'freschezza_badge.dart';
import 'set_contenitore_widget.dart';

/// Sections of the user guide, shown both in the help page and in the
/// introductory guide at first launch.
///
/// Each section has an example built with the real widgets of the app, so
/// the guide always matches the current look, language and theme.
enum SezioneGuida {
  calcolo(Icons.scale_outlined),
  gnam(Icons.restaurant),
  freschezza(Icons.eco_outlined),
  contenitori(Icons.inventory_2_outlined);

  const SezioneGuida(this.icona);

  /// Icon representing the section
  final IconData icona;

  /// Localized title of the section
  String titolo(AppLocalizations appLoc) => switch (this) {
    calcolo => appLoc.guideCalcTitle,
    gnam => appLoc.guideGnamTitle,
    freschezza => appLoc.guideFreshTitle,
    contenitori => appLoc.guideSetsTitle,
  };

  /// Localized explanation of the section
  String testo(AppLocalizations appLoc) => switch (this) {
    calcolo => appLoc.guideCalcText,
    gnam => appLoc.guideGnamText,
    freschezza => appLoc.guideFreshText,
    contenitori => appLoc.guideSetsText,
  };

  /// Example of the section, built with the real widgets of the app
  Widget get esempio => switch (this) {
    calcolo => const _EsempioCalcolo(),
    gnam => const _EsempioGnam(),
    freschezza => const _EsempioFreschezza(),
    contenitori => const _EsempioContenitori(),
  };
}

// Sample values shared by the examples, so they tell a consistent story:
// 540 g of rice in a 312 g container, split into 3 portions of 180 g.
const _pesoContenitore = 312.0;
const _pesoCibo = 540.0;
const _porzioni = 3;

/// Shows how the weights are calculated:
/// container + food = total, food ÷ portions = portion.
class _EsempioCalcolo extends StatelessWidget {
  const _EsempioCalcolo();

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    String grammi(double valore) =>
        '${formattaNumero(valore, appLoc.localeName)} g';

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Column(
          children: [
            _RigaFormula(
              operatori: const ['+', '='],
              valori: [
                (appLoc.guideLabelContainer, grammi(_pesoContenitore)),
                (appLoc.guideLabelFood, grammi(_pesoCibo)),
                (appLoc.guideLabelTotal, grammi(_pesoContenitore + _pesoCibo)),
              ],
            ),
            SizedBox(height: 10.h),
            _RigaFormula(
              operatori: const ['÷', '='],
              valori: [
                (appLoc.guideLabelFood, grammi(_pesoCibo)),
                (appLoc.guideLabelPortions, '$_porzioni'),
                (appLoc.guideLabelPortion, grammi(_pesoCibo / _porzioni)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// A row of the calculation example: `value op value op result`.
class _RigaFormula extends StatelessWidget {
  const _RigaFormula({required this.valori, required this.operatori});

  /// Label and value of each operand; the last one is the result.
  final List<(String, String)> valori;
  final List<String> operatori;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        for (final (i, (etichetta, valore)) in valori.indexed) ...[
          if (i > 0)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 6.w),
              child: Text(
                operatori[i - 1],
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          Expanded(
            child: _Operando(
              etichetta: etichetta,
              valore: valore,
              risultato: i == valori.length - 1,
            ),
          ),
        ],
      ],
    );
  }
}

class _Operando extends StatelessWidget {
  const _Operando({
    required this.etichetta,
    required this.valore,
    required this.risultato,
  });

  final String etichetta;
  final String valore;

  /// Whether this is the calculated value, which is highlighted.
  final bool risultato;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final colore = risultato
        ? colorScheme.onPrimaryContainer
        : colorScheme.onSurface;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 8.h),
      decoration: BoxDecoration(
        color: risultato
            ? colorScheme.primaryContainer
            : colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              etichetta,
              style: theme.textTheme.labelSmall?.copyWith(
                color: colore.withValues(alpha: 0.7),
              ),
            ),
          ),
          SizedBox(height: 2.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              valore,
              style: theme.textTheme.titleSmall?.copyWith(
                color: colore,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// A sample dish in the fridge, with its Gnam button.
class _EsempioGnam extends StatelessWidget {
  const _EsempioGnam();

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final oggi = DateTime.now();
    final ieri = DateTime(oggi.year, oggi.month, oggi.day - 1);

    return IgnorePointer(
      child: ContenitoreFrigoWidget(
        nomeContenitore: appLoc.guideSampleDish,
        pesoPorzione: _pesoCibo / _porzioni,
        porzioniDisponibili: _porzioni,
        dataInserimento: ieri,
        freschezza: Freschezza.calcola(
          dataCaricamento: ieri,
          durataGiorni: 3,
          oggi: oggi,
        ),
        // A callback is needed for the button to look enabled.
        gman: () {},
      ),
    );
  }
}

/// The three colors of the freshness badge, with their meaning.
class _EsempioFreschezza extends StatelessWidget {
  const _EsempioFreschezza();

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final oggi = DateTime.now();

    TableRow esempio(int giorniFa, String significato) => TableRow(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.h),
          child: Align(
            alignment: Alignment.centerLeft,
            child: FreschezzaBadge(
              freschezza: Freschezza.calcola(
                dataCaricamento: DateTime(
                  oggi.year,
                  oggi.month,
                  oggi.day - giorniFa,
                ),
                durataGiorni: 3,
                oggi: oggi,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 12.w),
          child: Text(
            significato,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
        ),
      ],
    );

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
        child: Table(
          columnWidths: const {0: IntrinsicColumnWidth(), 1: FlexColumnWidth()},
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            esempio(0, appLoc.freshnessFresh),
            esempio(2, appLoc.freshnessExpiring),
            esempio(5, appLoc.freshnessExpired),
          ],
        ),
      ),
    );
  }
}

/// A sample saved container.
class _EsempioContenitori extends StatelessWidget {
  const _EsempioContenitori();

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return SetContenitoreWidget(
      nome: appLoc.guideSampleContainer,
      pesoInGrammi: _pesoContenitore,
      pathImmagine: '',
    );
  }
}
