import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../l10n/app_localizations.dart';
import '../models/freschezza.dart';
import '../theme/theme.dart';

/// Badge showing how long ago the food was stored, colored by its freshness:
/// green when fresh, orange when it should be eaten soon, red when expired.
///
/// The freshness status is also exposed as tooltip and to screen readers.
class FreschezzaBadge extends StatelessWidget {
  const FreschezzaBadge({super.key, required this.freschezza});

  final Freschezza freschezza;

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final (color, icon, stato) = switch (freschezza.stato) {
      StatoFreschezza.fresco => (
        isDark ? DarkColors.fresh : LightColors.fresh,
        Icons.check_circle_outline,
        appLoc.freshnessFresh,
      ),
      StatoFreschezza.inScadenza => (
        isDark ? DarkColors.expiring : LightColors.expiring,
        Icons.schedule,
        appLoc.freshnessExpiring,
      ),
      StatoFreschezza.scaduto => (
        theme.colorScheme.error,
        Icons.error_outline,
        appLoc.freshnessExpired,
      ),
    };
    final eta = appLoc.freshnessAge(freschezza.giorni);

    return Tooltip(
      message: stato,
      child: Semantics(
        label: '$eta, $stato',
        excludeSemantics: true,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 3.h),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 14.w, color: color),
              SizedBox(width: 4.w),
              Text(
                eta,
                style: theme.textTheme.labelSmall?.copyWith(
                  color: color,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
