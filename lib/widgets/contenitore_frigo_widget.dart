import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../l10n/app_localizations.dart';
import '../models/freschezza.dart';
import '../utils/formato.dart';
import 'freschezza_badge.dart';

/// Widget representing a fridge container item
///
/// Displays the container name, available quantity, available portions,
/// the date it was added and its freshness using a modern card-based layout.
class ContenitoreFrigoWidget extends StatelessWidget {
  const ContenitoreFrigoWidget({
    super.key,
    required this.nomeContenitore,
    required this.pesoPorzione,
    required this.porzioniDisponibili,
    required this.dataInserimento,
    required this.freschezza,
    this.nelFreezer = false,
    this.gman,
  });

  final String nomeContenitore;
  final double pesoPorzione;
  final int porzioniDisponibili;
  final DateTime dataInserimento;
  final Freschezza freschezza;
  final bool nelFreezer;
  final Function()? gman;

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Row(
          children: [
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: colorScheme.primaryContainer,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                nelFreezer ? Icons.ac_unit : Icons.kitchen,
                color: colorScheme.onPrimaryContainer,
                size: 24.w,
              ),
            ),
            SizedBox(width: 14.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          nomeContenitore,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      FreschezzaBadge(freschezza: freschezza),
                    ],
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    localizations.containerPortionWeight(
                      formattaNumero(pesoPorzione, localizations.localeName),
                    ),
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Wrap(
                    spacing: 12.w,
                    runSpacing: 2.h,
                    children: [
                      Text(
                        localizations.containerNrPortion(
                          porzioniDisponibili.toString(),
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        localizations.containerUploadDate(
                          formattaData(
                            dataInserimento,
                            localizations.localeName,
                          ),
                        ),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurface.withValues(alpha: 0.5),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: gman,
              icon: Icon(Icons.restaurant, color: colorScheme.secondary),
              tooltip: 'Gnam!',
              style: IconButton.styleFrom(
                backgroundColor: colorScheme.secondaryContainer.withValues(
                  alpha: 0.5,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
