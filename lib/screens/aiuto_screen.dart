import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../l10n/app_localizations.dart';
import '../widgets/guida_sezioni.dart';

/// Help screen explaining how to use the app.
///
/// Each section shows an example built with the real widgets of the app
/// (see [SezioneGuida]), so it stays up to date with the current look.
class AiutoScreen extends StatelessWidget {
  const AiutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final mutedColor = theme.colorScheme.onSurface.withValues(alpha: 0.7);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.help_title)),
      body: ListView(
        padding: EdgeInsets.symmetric(vertical: 20.h),
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: Text(
              l10n.help_intro,
              style: theme.textTheme.bodyLarge?.copyWith(color: mutedColor),
            ),
          ),
          SizedBox(height: 12.h),
          for (final sezione in SezioneGuida.values) ...[
            SizedBox(height: 16.h),
            _IntestazioneSezione(sezione: sezione),
            SizedBox(height: 8.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text(
                sezione.testo(l10n),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: mutedColor,
                  height: 1.4,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            sezione.esempio,
            SizedBox(height: 8.h),
          ],
          SizedBox(height: 24.h),
          Center(
            child: Text(
              l10n.help_thanks,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: mutedColor,
                fontStyle: FontStyle.italic,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Icon and title of a section of the guide.
class _IntestazioneSezione extends StatelessWidget {
  const _IntestazioneSezione({required this.sezione});

  final SezioneGuida sezione;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: colorScheme.primaryContainer,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              sezione.icona,
              size: 20.w,
              color: colorScheme.onPrimaryContainer,
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              sezione.titolo(AppLocalizations.of(context)!),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
