import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.title,
    this.text,
    required this.onClick,
  });

  final String title;
  final String? text;
  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (text != null)
          Text(
            text!,
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontSize: 14.sp,
            ),
          ),
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          ),
          onPressed: onClick,
          child: Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline, // اختيار اختياري لتمييزه كزرار
            ),
          ),
        )
      ],
    );
  }
}