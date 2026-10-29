import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

import '../l10n/app_localizations.dart';
import '../utils/formato.dart';
import '../widgets/input_dettaglio_contenitore_widget.dart';

/// A modal bottom sheet form for adding a new container set.
///
/// Provides fields for name, weight, and image selection (camera/gallery).
/// On save, calls [onSave] with the entered values and the selected image path.
class AggiungiSetContenitoreBottomSheet extends StatefulWidget {
  const AggiungiSetContenitoreBottomSheet({super.key, required this.onSave});

  /// Callback invoked when the user saves the form.
  /// Parameters: (nome, pathImmagine, pesoInGrammi).
  final void Function(String nome, String pathImmagine, double pesoInGrammi)
  onSave;

  @override
  State<AggiungiSetContenitoreBottomSheet> createState() =>
      _AggiungiSetContenitoreBottomSheetState();
}

class _AggiungiSetContenitoreBottomSheetState
    extends State<AggiungiSetContenitoreBottomSheet> {
  final _nameController = TextEditingController();
  final _weightController = TextEditingController();
  String? _nameError;
  String? _weightError;
  final _imagePicker = ImagePicker();
  String _imagePath = '';

  @override
  void dispose() {
    _nameController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final appLoc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 16.h,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24.h,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Drag handle
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                decoration: BoxDecoration(
                  color: theme.colorScheme.outline.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            SizedBox(height: 16.h),

            // Title
            Text(
              appLoc.containerSetsAddTitle,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 24.h),

            // Name field
            InputDettaglioContenitoreWidget(
              label: appLoc.containerSetsNameLabel,
              controller: _nameController,
              errorText: _nameError,
            ),

            // Weight field
            InputDettaglioContenitoreWidget(
              label: appLoc.containerSetsWeightLabel,
              controller: _weightController,
              errorText: _weightError,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: const [DecimaleInputFormatter()],
            ),

            // Image section
            Text(
              appLoc.containerSetsImageLabel,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
              ),
            ),
            SizedBox(height: 8.h),

            // Image preview + pick button
            Row(
              children: [
                // Image preview
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: SizedBox(
                    width: 80.w,
                    height: 80.w,
                    child: _buildImagePreview(theme),
                  ),
                ),
                SizedBox(width: 16.w),

                // Choose image button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => _showImageSourceDialog(context),
                    icon: const Icon(Icons.add_a_photo_outlined),
                    label: Text(appLoc.containerSetsImageChoose),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(
                        horizontal: 16.w,
                        vertical: 12.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),

            // Save button
            SizedBox(
              width: double.maxFinite,
              child: ElevatedButton(
                onPressed: _onSave,
                child: Text(appLoc.containerSetsSaveButton),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Builds the image preview, showing the selected image or a placeholder.
  Widget _buildImagePreview(ThemeData theme) {
    if (_imagePath.isNotEmpty && File(_imagePath).existsSync()) {
      return Image.file(File(_imagePath), fit: BoxFit.cover);
    }
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(
        Icons.image_outlined,
        size: 32.w,
        color: theme.colorScheme.outline,
      ),
    );
  }

  /// Shows a dialog to choose between camera and gallery.
  Future<void> _showImageSourceDialog(BuildContext context) async {
    final appLoc = AppLocalizations.of(context)!;

    await showModalBottomSheet<void>(
      context: context,
      builder: (ctx) => SafeArea(
        child: Wrap(
          children: [
            ListTile(
              leading: const Icon(Icons.camera_alt_outlined),
              title: Text(appLoc.containerSetsImageCamera),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickImage(ImageSource.camera);
              },
            ),
            ListTile(
              leading: const Icon(Icons.photo_library_outlined),
              title: Text(appLoc.containerSetsImageGallery),
              onTap: () {
                Navigator.of(ctx).pop();
                _pickImage(ImageSource.gallery);
              },
            ),
          ],
        ),
      ),
    );
  }

  /// Picks an image from the given [source] and updates the preview.
  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _imagePicker.pickImage(
        source: source,
        maxWidth: 1024,
        maxHeight: 1024,
        imageQuality: 85,
      );
      if (pickedFile != null) {
        setState(() {
          _imagePath = pickedFile.path;
        });
      }
    } catch (e) {
      // Permission denied or other error — silently handled.
      // The user can retry by tapping the button again.
      debugPrint('Image picker error: $e');
    }
  }

  /// Validates the form and calls the [onSave] callback.
  void _onSave() {
    final nome = _nameController.text.trim();
    final peso = parseDecimale(_weightController.text) ?? 0;

    final appLoc = AppLocalizations.of(context)!;

    setState(() {
      _nameError = nome.isEmpty ? appLoc.containerSetsNameRequired : null;
      _weightError = peso <= 0 ? appLoc.containerSetsWeightInvalid : null;
    });
    if (_nameError != null || _weightError != null) return;

    widget.onSave(nome, _imagePath, peso);
    Navigator.of(context).pop();
  }
}
