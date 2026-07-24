import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../authentication/widgets/custom_text_button.dart';

class DateTimeRowWidget extends StatelessWidget {
  const DateTimeRowWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.buttonTitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String buttonTitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(icon, color: theme.colorScheme.onSurface),
        SizedBox(width: 10.w),
        Text(title, style: theme.textTheme.labelSmall),
        const Spacer(),
        CustomTextButton(
          title: buttonTitle,
          onClick: onTap,
        ),
      ],
    );
  }
}