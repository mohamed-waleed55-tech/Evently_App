import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final bool isSecure;
  final int maxLines;
  final bool enabled;
  final bool readOnly;
  final FocusNode? focusNode;
  final VoidCallback? onClick;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  const CustomTextFormField({
    super.key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.isSecure = false,
    this.maxLines = 1,
    this.enabled = true,
    this.readOnly = false,
    this.focusNode,
    this.onClick,
    this.onTap,
    this.onChange,
    this.validator,
    this.controller,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,

  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      validator: validator,
      onChanged: onChange,
      onTap: onTap,
      enabled: enabled,
      readOnly: readOnly,
      obscureText: isSecure,
      maxLines: isSecure ? 1 : maxLines,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      autofillHints: autofillHints,
      style: theme.textTheme.bodyLarge?.copyWith(
        color: colorScheme.onSurface,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefixIcon != null
            ? Icon(
                prefixIcon,
                color: colorScheme.onSurfaceVariant,
              )
            : null,
        suffixIcon: suffixIcon != null
            ? IconButton(
                onPressed: onClick,
                icon: Icon(
                  suffixIcon,
                  color: colorScheme.onSurfaceVariant,
                ),
              )
            : null,
      ),
    );
  }
}