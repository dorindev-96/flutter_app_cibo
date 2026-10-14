import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/freschezza_constants.dart';
import '../l10n/app_localizations.dart';

/// Shows a dialog to set how many days food keeps.
///
/// Returns the number of days entered, or `null` if the dialog is cancelled.
Future<int?> showDurataFreschezzaDialog(
  BuildContext context, {
  required String titolo,
  required int giorni,
}) => showDialog<int>(
  context: context,
  builder: (_) => _DurataFreschezzaDialog(titolo: titolo, giorni: giorni),
);

class _DurataFreschezzaDialog extends StatefulWidget {
  const _DurataFreschezzaDialog({required this.titolo, required this.giorni});

  final String titolo;
  final int giorni;

  @override
  State<_DurataFreschezzaDialog> createState() =>
      _DurataFreschezzaDialogState();
}

class _DurataFreschezzaDialogState extends State<_DurataFreschezzaDialog> {
  late final _controller = TextEditingController(text: '${widget.giorni}');

  /// The number of days entered, or `null` if it is out of range.
  int? get _giorni {
    final giorni = int.tryParse(_controller.text);
    return giorni != null &&
            giorni >= minGiorniFreschezza &&
            giorni <= maxGiorniFreschezza
        ? giorni
        : null;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _salva() {
    final giorni = _giorni;
    if (giorni != null) Navigator.of(context).pop(giorni);
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;

    return AlertDialog(
      title: Text(widget.titolo),
      content: TextField(
        controller: _controller,
        autofocus: true,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter('$maxGiorniFreschezza'.length),
        ],
        decoration: InputDecoration(
          labelText: appLoc.settings_freshness_days_label,
        ),
        onChanged: (_) => setState(() {}),
        onSubmitted: (_) => _salva(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text(appLoc.gen_Cancel),
        ),
        TextButton(
          onPressed: _giorni == null ? null : _salva,
          child: Text(appLoc.gen_Save),
        ),
      ],
    );
  }
}
