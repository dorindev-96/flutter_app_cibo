import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../l10n/app_localizations.dart';
import '../main.dart';
import '../utils/formato.dart';

/// A widget displaying a single container set item in a list.
///
/// Shows a thumbnail image (or placeholder), the container name,
/// and the tare weight in grams.
class SetContenitoreWidget extends StatelessWidget {
  const SetContenitoreWidget({
    super.key,
    required this.nome,
    required this.pesoInGrammi,
    required this.pathImmagine,
  });

  /// Display name of the container set.
  final String nome;

  /// Tare weight in grams.
  final double pesoInGrammi;

  /// File system path to the container image.
  final String pathImmagine;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLoc = AppLocalizations.of(context)!;
    final weightText = formattaNumero(pesoInGrammi, appLoc.localeName);

    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
      child: Padding(
        padding: EdgeInsets.all(12.w),
        child: Row(
          children: [
            // Image thumbnail or placeholder
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 64.w,
                height: 64.w,
                child: _buildImage(theme),
              ),
            ),
            SizedBox(width: 16.w),
            // Name and weight info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nome.isNotEmpty ? nome : appLoc.no_name,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    appLoc.containerSetsWeight(weightText),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the image widget from file path, falling back to a placeholder.
  Widget _buildImage(ThemeData theme) {
    final file = immaginiService.risolvi(pathImmagine);
    if (file != null) {
      return Image.file(
        file,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(theme),
      );
    }
    return _placeholder(theme);
  }

  /// Placeholder icon when no image is available.
  Widget _placeholder(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.inventory_2_outlined,
        size: 32.w,
        color: theme.colorScheme.outline,
      ),
    );
  }
}
