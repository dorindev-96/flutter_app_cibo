import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../l10n/app_localizations.dart';
import '../widgets/custom_image_widget.dart';

class AiutoScreen extends StatelessWidget {
  const AiutoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;
    final numberStyle = TextStyle(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
      fontSize: 16.sp,
    );
    final textStyle = TextStyle(fontSize: 14.sp, height: 1.5);

    Widget styledNumber(String number) {
      return Text(' ($number) ', style: numberStyle);
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.help_title)),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.outline.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 350.h,
                    child: CustomImageWidget(
                      themeMode: theme.brightness == Brightness.dark
                          ? ThemeMode.dark
                          : ThemeMode.light,
                      imagePathLight: 'assets/Images/Screenshot_1_l.png',
                      imagePathDark: 'assets/Images/Screenshot_1_d.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: theme.colorScheme.outline.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    height: 350.h,
                    child: CustomImageWidget(
                      themeMode: theme.brightness == Brightness.dark
                          ? ThemeMode.dark
                          : ThemeMode.light,
                      imagePathLight: 'assets/Images/Screenshot_2_l.png',
                      imagePathDark: 'assets/Images/Screenshot_2_d.png',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 28.h),
            // Introduction
            Text(
              l10n.help_intro,
              style: textStyle.copyWith(fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 16.h),
            // Step 1-2
            Text.rich(
              TextSpan(
                style: textStyle,
                children: [
                  TextSpan(text: l10n.help_step1),
                  WidgetSpan(child: styledNumber('1')),
                  TextSpan(text: l10n.help_step2),
                  WidgetSpan(child: styledNumber('2')),
                  TextSpan(text: l10n.help_step2_note),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Step 3
            Text.rich(
              TextSpan(
                style: textStyle,
                children: [
                  TextSpan(text: l10n.help_step3),
                  WidgetSpan(child: styledNumber('7')),
                  TextSpan(text: l10n.help_step3_note),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Step 4
            Text.rich(
              TextSpan(
                style: textStyle,
                children: [
                  TextSpan(text: l10n.help_step4),
                  WidgetSpan(child: styledNumber('3')),
                  TextSpan(text: ', '),
                  TextSpan(text: l10n.help_step5),
                  WidgetSpan(child: styledNumber('4')),
                  TextSpan(text: l10n.help_step5_note),
                  WidgetSpan(child: styledNumber('3')),
                  TextSpan(text: l10n.help_step5_end),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Step 5-6
            Text.rich(
              TextSpan(
                style: textStyle,
                children: [
                  TextSpan(text: l10n.help_step6),
                  WidgetSpan(child: styledNumber('5')),
                  TextSpan(text: l10n.help_step6_note),
                  WidgetSpan(child: styledNumber('6')),
                  TextSpan(text: l10n.help_step6_end),
                ],
              ),
            ),
            SizedBox(height: 12.h),
            // Step 7
            Text.rich(
              TextSpan(
                style: textStyle,
                children: [
                  TextSpan(text: l10n.help_step7),
                  WidgetSpan(child: styledNumber('7')),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Gnam button
            Text.rich(
              TextSpan(
                style: textStyle,
                children: [
                  TextSpan(text: l10n.help_gnam),
                  WidgetSpan(child: styledNumber('8')),
                  TextSpan(text: l10n.help_gnam_note),
                ],
              ),
            ),
            SizedBox(height: 16.h),
            // Freshness badge
            Text(l10n.help_freshness, style: textStyle),
            SizedBox(height: 28.h),
            // Thanks
            Center(
              child: Text(
                l10n.help_thanks,
                style: textStyle.copyWith(fontStyle: FontStyle.italic),
              ),
            ),
            SizedBox(height: 32.h),
          ],
        ),
      ),
    );
  }
}
