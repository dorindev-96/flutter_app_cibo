/// Freshness of the food in a container
library;

import 'dart:math';

/// Freshness level of the food, used to color its badge.
enum StatoFreschezza {
  /// Well within its shelf life.
  fresco,

  /// In the last part of its shelf life: to be eaten soon.
  inScadenza,

  /// Past its shelf life.
  scaduto,
}

/// Freshness of the food in a container, computed from the day it was
/// stored and its shelf life.
class Freschezza {
  const Freschezza._({
    required this.giorni,
    required this.giorniRimanenti,
    required this.stato,
  });

  /// Computes the freshness, as of [oggi], of food stored on
  /// [dataCaricamento] that keeps for [durataGiorni] days.
  ///
  /// The food is [StatoFreschezza.inScadenza] during the last quarter of its
  /// shelf life, and at least on its last day: e.g. on days 2 and 3 when it
  /// keeps 3 days in the fridge, or in the last ~3 weeks out of 90 days in
  /// the freezer.
  factory Freschezza.calcola({
    required DateTime dataCaricamento,
    required int durataGiorni,
    required DateTime oggi,
  }) {
    final giorni = max(0, _giorniDiCalendario(dataCaricamento, oggi));
    final giorniRimanenti = durataGiorni - giorni;
    final stato = giorniRimanenti < 0
        ? StatoFreschezza.scaduto
        : giorniRimanenti <= (durataGiorni / 4).ceil()
        ? StatoFreschezza.inScadenza
        : StatoFreschezza.fresco;

    return Freschezza._(
      giorni: giorni,
      giorniRimanenti: giorniRimanenti,
      stato: stato,
    );
  }

  /// Days elapsed since the food was stored (0 = stored today).
  final int giorni;

  /// Days left until the end of the shelf life (negative once past it).
  final int giorniRimanenti;

  /// Freshness level of the food.
  final StatoFreschezza stato;

  /// Calendar days from [da] to [a], ignoring the time of day and DST.
  static int _giorniDiCalendario(DateTime da, DateTime a) => DateTime.utc(
    a.year,
    a.month,
    a.day,
  ).difference(DateTime.utc(da.year, da.month, da.day)).inDays;
}
