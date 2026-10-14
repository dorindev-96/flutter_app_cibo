/// Locale-aware parsing and formatting of numbers and dates
library;

import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

/// Parses a decimal number typed by the user.
///
/// Accepts both "," and "." as decimal separator, so values typed with the
/// keyboard of any supported locale (e.g. "12,5" in Italian) are read
/// correctly. Returns `null` for empty or invalid text.
double? parseDecimale(String testo) =>
    double.tryParse(testo.trim().replaceAll(',', '.'));

/// Formats [valore] for [locale] with at most two decimals and no grouping
/// (e.g. `150` or `133,33` in Italian, `133.33` in English).
///
/// Grouping is omitted so the result can be read back by [parseDecimale].
String formattaNumero(double valore, String locale) =>
    NumberFormat('0.##', locale).format(valore);

/// Formats [data] as a short numeric date for [locale]
/// (e.g. `14/10/2026` in Italian, `10/14/2026` in English).
String formattaData(DateTime data, String locale) =>
    DateFormat.yMd(locale).format(data);

/// Input formatter for decimal numbers: digits with a single "," or "."
/// separator and at most two decimals. Invalid edits are rejected.
class DecimaleInputFormatter extends TextInputFormatter {
  const DecimaleInputFormatter();

  static final _valido = RegExp(r'^\d*([.,]\d{0,2})?$');

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) => _valido.hasMatch(newValue.text) ? newValue : oldValue;
}
