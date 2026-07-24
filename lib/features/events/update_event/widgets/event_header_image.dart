import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EventHeaderImage extends StatelessWidget {
  const EventHeaderImage({super.key, required this.imagePath});

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16.r),
      child: Image.asset(
        imagePath,
        width: double.infinity,
        height: 180.h,
        fit: BoxFit.cover,
      ),
    );
  }
}