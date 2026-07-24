
import 'package:evently/core/app_validators/app_validators.dart';
import 'package:evently/features/authentication/widgets/custom_text_form_field.dart';
import 'package:evently/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventFormFields extends StatelessWidget {
  final TextEditingController titleController;
  final TextEditingController descController;

  const EventFormFields({
    super.key,
    required this.titleController,
    required this.descController,
  });

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          loc.title,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          validator: AppValidators.validateTitle,
          hint: loc.eventTitle,
          prefixIcon: Icons.edit_note_rounded,
          controller: titleController,
        ),
        SizedBox(height: 16.h),
        Text(
          loc.description,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
            color: colorScheme.onSurface,
          ),
        ),
        SizedBox(height: 8.h),
        CustomTextFormField(
          validator: AppValidators.validateDescription,
          hint: loc.eventDesc,
          maxLines: 4,
          controller: descController,
        ),
      ],
    );
  }
}
