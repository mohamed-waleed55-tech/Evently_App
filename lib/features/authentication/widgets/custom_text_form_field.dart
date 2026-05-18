import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final IconData? prefixIcon;
  final String? hint;
  final int lines;
  final IconData? suffixIcon;
  final bool isSecure;
  final VoidCallback? onClick;
  final Function(String)? onChange;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Iterable<String>? autofillHints;

  const CustomTextFormField({
    super.key,
    this.lines = 1,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.isSecure = false,
    this.onClick,
    this.hint,
    this.controller,
    this.validator,
    this.onChange,
    this.keyboardType,
    this.textInputAction,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      validator: validator,
      keyboardType: keyboardType ?? TextInputType.text,
      textInputAction: textInputAction ?? TextInputAction.next,
      autofillHints: autofillHints,
      controller: controller,
      style: Theme.of(context).textTheme.bodyLarge,
      obscureText: isSecure,
      maxLines: lines,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefixIcon: prefixIcon != null ? Icon(prefixIcon) : null,
        // Only show suffix icon if it's actually provided
        suffixIcon: suffixIcon != null
            ? IconButton(onPressed: onClick, icon: Icon(suffixIcon))
            : null,
      ),
    );
  }
}