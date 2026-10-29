import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// A widget that displays a labeled input field for container details.
///
/// The [label] parameter specifies the text label for the input field.
/// The [controller] parameter allows access to the text field value.
class InputDettaglioContenitoreWidget extends StatefulWidget {
  const InputDettaglioContenitoreWidget({
    super.key,
    required this.label,
    required this.controller,
    this.keyboardType = TextInputType.text,
    this.inputFormatters,
    this.suffixIcon,
    this.readOnly = false,
    this.onTap,
    this.errorText,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;

  /// Optional formatters restricting what the user can type.
  final List<TextInputFormatter>? inputFormatters;

  /// Optional icon widget displayed at the end of the text field.
  final Widget? suffixIcon;

  /// Whether the text can only be changed through [onTap] (e.g. a picker).
  final bool readOnly;

  /// Optional callback invoked when the field is tapped.
  final VoidCallback? onTap;

  /// Optional error message shown below the text field.
  final String? errorText;

  @override
  State<InputDettaglioContenitoreWidget> createState() =>
      _InputDettaglioContenitoreWidgetState();
}

class _InputDettaglioContenitoreWidgetState
    extends State<InputDettaglioContenitoreWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.label,
            style: theme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            key: widget.key,
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            inputFormatters: widget.inputFormatters,
            readOnly: widget.readOnly,
            onTap: widget.onTap,
            decoration: InputDecoration(
              suffixIcon: widget.suffixIcon,
              errorText: widget.errorText,
            ),
          ),
        ],
      ),
    );
  }
}
