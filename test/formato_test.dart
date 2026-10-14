import 'package:cibo/utils/formato.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';

void main() {
  setUpAll(() => initializeDateFormatting());

  group('parseDecimale', () {
    test('accepts both comma and dot as decimal separator', () {
      expect(parseDecimale('12,5'), 12.5);
      expect(parseDecimale('12.5'), 12.5);
      expect(parseDecimale(' 7 '), 7);
    });

    test('returns null for empty or invalid text', () {
      expect(parseDecimale(''), isNull);
      expect(parseDecimale('abc'), isNull);
      expect(parseDecimale('1,2,3'), isNull);
    });
  });

  group('formattaNumero', () {
    test('drops useless decimals', () {
      expect(formattaNumero(150, 'it'), '150');
      expect(formattaNumero(150.0, 'en'), '150');
    });

    test('uses the decimal separator of the locale', () {
      expect(formattaNumero(133.333, 'it'), '133,33');
      expect(formattaNumero(133.333, 'de'), '133,33');
      expect(formattaNumero(133.333, 'en'), '133.33');
    });

    test('does not group thousands, so it can be parsed back', () {
      final testo = formattaNumero(1234.5, 'it');
      expect(testo, '1234,5');
      expect(parseDecimale(testo), 1234.5);
    });
  });

  test('formattaData follows the locale', () {
    final data = DateTime(2026, 10, 14);
    expect(formattaData(data, 'it'), '14/10/2026');
    expect(formattaData(data, 'en'), '10/14/2026');
    expect(formattaData(data, 'de'), '14.10.2026');
  });

  group('DecimaleInputFormatter', () {
    const formatter = DecimaleInputFormatter();
    const vecchio = TextEditingValue(text: '12');

    String applica(String testo) =>
        formatter.formatEditUpdate(vecchio, TextEditingValue(text: testo)).text;

    test('accepts numbers with one separator and up to two decimals', () {
      expect(applica('12,5'), '12,5');
      expect(applica('12.50'), '12.50');
      expect(applica(''), '');
    });

    test('rejects invalid edits keeping the previous value', () {
      expect(applica('12,555'), '12');
      expect(applica('1.2.3'), '12');
      expect(applica('12a'), '12');
      expect(applica('-3'), '12');
    });
  });
}
