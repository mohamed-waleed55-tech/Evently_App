import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../authentication/widgets/custom_text_form_field.dart';

class EventTextField extends StatelessWidget {
  const EventTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.controller,
    required this.validator,
    this.prefixIcon,
    this.maxLines = 1,
  });

  final String label;
  final String hint;
  final TextEditingController controller;
  final String? Function(String?) validator;
  final IconData? prefixIcon;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: theme.textTheme.labelSmall),
        SizedBox(height: 8.h),
        CustomTextFormField(
          validator: validator,
          hint: hint,
          prefixIcon: prefixIcon,
          maxLines: maxLines,
          controller: controller,
        ),
      ],
    );
  }
}