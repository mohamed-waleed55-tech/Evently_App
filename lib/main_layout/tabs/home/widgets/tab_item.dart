import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../DM/CategoryDM.dart';
import '../../../../core/resources/colors/colors_manager.dart';

class CustomTabItem extends StatelessWidget {
  const CustomTabItem({
    super.key,
    required this.categoryDM,
    required this.isSelected,
    this.onTap,
    this.selectedBackgroundColor = ColorsManager.offWhite,
    this.unselectedBorderColor = ColorsManager.offWhite,
    this.selectedContentColor = ColorsManager.blue,
    this.unselectedContentColor = ColorsManager.offWhite,
    this.borderRadius = 30,
    this.padding,
  });

  final CategoryDM categoryDM;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color selectedBackgroundColor;
  final Color unselectedBorderColor;
  final Color selectedContentColor;
  final Color unselectedContentColor;
  final double borderRadius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final contentColor = isSelected
        ? selectedContentColor
        : unselectedContentColor;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        padding:
            padding ?? const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected ? selectedBackgroundColor : Colors.transparent,
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: isSelected ? selectedBackgroundColor : unselectedBorderColor,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              categoryDM.icon,
              color: contentColor,
            ),
            const SizedBox(width: 6),
            Text(
              categoryDM.name,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                color: contentColor,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
