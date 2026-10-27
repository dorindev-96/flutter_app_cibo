import 'package:cibo/models/freschezza.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final oggi = DateTime(2026, 10, 14, 12);

  Freschezza calcola({required int giorniFa, required int durata}) =>
      Freschezza.calcola(
        dataCaricamento: oggi.subtract(Duration(days: giorniFa)),
        durataGiorni: durata,
        oggi: oggi,
      );

  test('fridge (3 days): fresh, then to eat soon, then expired', () {
    expect(calcola(giorniFa: 0, durata: 3).stato, StatoFreschezza.fresco);
    expect(calcola(giorniFa: 1, durata: 3).stato, StatoFreschezza.fresco);
    expect(calcola(giorniFa: 2, durata: 3).stato, StatoFreschezza.inScadenza);
    expect(calcola(giorniFa: 3, durata: 3).stato, StatoFreschezza.inScadenza);
    expect(calcola(giorniFa: 4, durata: 3).stato, StatoFreschezza.scaduto);
  });

  test('1-day shelf life: fresh on the day it is stored', () {
    expect(calcola(giorniFa: 0, durata: 1).stato, StatoFreschezza.fresco);
    expect(calcola(giorniFa: 1, durata: 1).stato, StatoFreschezza.inScadenza);
    expect(calcola(giorniFa: 2, durata: 1).stato, StatoFreschezza.scaduto);
  });

  test('freezer (90 days): to eat soon in the last quarter', () {
    expect(calcola(giorniFa: 66, durata: 90).stato, StatoFreschezza.fresco);
    expect(calcola(giorniFa: 67, durata: 90).stato, StatoFreschezza.inScadenza);
    expect(calcola(giorniFa: 90, durata: 90).stato, StatoFreschezza.inScadenza);
    expect(calcola(giorniFa: 91, durata: 90).stato, StatoFreschezza.scaduto);
  });

  test('counts days left until the end of the shelf life', () {
    expect(calcola(giorniFa: 1, durata: 3).giorniRimanenti, 2);
    expect(calcola(giorniFa: 5, durata: 3).giorniRimanenti, -2);
  });

  test('counts calendar days, ignoring the time of day', () {
    final freschezza = Freschezza.calcola(
      dataCaricamento: DateTime(2026, 10, 13, 23, 59),
      durataGiorni: 3,
      oggi: DateTime(2026, 10, 14, 0, 1),
    );
    expect(freschezza.giorni, 1);
  });

  test('counts calendar days across a daylight saving time change', () {
    final freschezza = Freschezza.calcola(
      dataCaricamento: DateTime(2026, 3, 28),
      durataGiorni: 3,
      oggi: DateTime(2026, 3, 30),
    );
    expect(freschezza.giorni, 2);
  });

  test('a date in the future counts as today', () {
    final freschezza = Freschezza.calcola(
      dataCaricamento: oggi.add(const Duration(days: 2)),
      durataGiorni: 3,
      oggi: oggi,
    );
    expect(freschezza.giorni, 0);
    expect(freschezza.stato, StatoFreschezza.fresco);
  });
}
