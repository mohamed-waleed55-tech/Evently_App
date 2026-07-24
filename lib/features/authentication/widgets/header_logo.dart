import 'package:evently/core/resources/images/images_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HeaderLogo extends StatelessWidget {
  const HeaderLogo({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
  child: Container(
    padding: REdgeInsets.all(25),
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: colorScheme.primaryContainer.withOpacity(0.5),
      
    ),
    child: Image.asset(
      ImagesManager.lightLogo,
      height: 100.h,
      width: 100.h, 
      fit: BoxFit.contain,
    ),
  ),
);
  }
}