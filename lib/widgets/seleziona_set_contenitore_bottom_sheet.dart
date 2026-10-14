import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../l10n/app_localizations.dart';
import '../main.dart';
import '../models/entities/set_contenitori_entity.dart';
import '../repositories/set_contenitori_repository.dart';
import '../utils/formato.dart';

/// A bottom sheet that displays saved container presets for selection.
///
/// When a preset is selected, [onSelected] is called with the chosen entity,
/// allowing the caller to populate name and weight fields automatically.
class SelezionaSetContenitoreBottomSheet extends StatelessWidget {
  const SelezionaSetContenitoreBottomSheet({
    super.key,
    required this.onSelected,
  });

  /// Callback invoked when a preset container is selected.
  final void Function(SetContenitoriEntity selected) onSelected;

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final repository = SetContenitoriRepository();
    final presets = repository.getAll();

    return SafeArea(
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.only(
            top: 16.h,
            bottom: MediaQuery.of(context).viewInsets.bottom + 16.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Drag handle
              Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 16.h),

              // Title
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Text(
                  appLoc.presetPickerTitle,
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              SizedBox(height: 16.h),

              // Content
              if (presets.isEmpty)
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 20.w,
                    vertical: 32.h,
                  ),
                  child: Column(
                    children: [
                      Icon(
                        Icons.inventory_2_outlined,
                        size: 48.w,
                        color: theme.colorScheme.outline,
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        appLoc.presetPickerEmpty,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.colorScheme.onSurface.withValues(
                            alpha: 0.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              else
                ConstrainedBox(
                  constraints: BoxConstraints(maxHeight: 300.h),
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    itemCount: presets.length,
                    separatorBuilder: (_, __) => SizedBox(height: 4.h),
                    itemBuilder: (context, index) {
                      final preset = presets[index];
                      return _PresetTile(
                        preset: preset,
                        onTap: () {
                          onSelected(preset);
                          Navigator.of(context).pop();
                        },
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single tile for a container preset in the picker list.
class _PresetTile extends StatelessWidget {
  const _PresetTile({required this.preset, required this.onTap});

  final SetContenitoriEntity preset;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final appLoc = AppLocalizations.of(context)!;
    final weightText = formattaNumero(preset.pesoInGrammi, appLoc.localeName);

    return Card(
      margin: EdgeInsets.zero,
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(width: 48.w, height: 48.w, child: _buildImage(theme)),
        ),
        title: Text(
          preset.nome.isNotEmpty ? preset.nome : appLoc.no_name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        subtitle: Text(
          appLoc.containerSetsWeight(weightText),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
          ),
        ),
        trailing: Icon(Icons.chevron_right, color: theme.colorScheme.outline),
        onTap: onTap,
      ),
    );
  }

  Widget _buildImage(ThemeData theme) {
    final file = immaginiService.risolvi(preset.pathImmagine);
    if (file != null) {
      return Image.file(
        file,
        fit: BoxFit.cover,
        errorBuilder: (_, __, ___) => _placeholder(theme),
      );
    }
    return _placeholder(theme);
  }

  Widget _placeholder(ThemeData theme) {
    return Container(
      color: theme.colorScheme.surfaceContainerHighest,
      child: Icon(
        Icons.inventory_2_outlined,
        size: 24.w,
        color: theme.colorScheme.outline,
      ),
    );
  }
}
