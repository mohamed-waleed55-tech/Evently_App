import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../DM/CategoryDM.dart';

class CustomTabItem extends StatelessWidget {
  const CustomTabItem({
    super.key,
    required this.categoryDM,
    required this.isSelected,
    this.onTap,
    this.selectedBackgroundColor,
    this.unselectedBorderColor,
    this.selectedContentColor,
    this.unselectedContentColor,
    this.borderRadius = 20,
    this.padding,
  });

  final CategoryDM categoryDM;
  final bool isSelected;
  final VoidCallback? onTap;
  final Color? selectedBackgroundColor;
  final Color? unselectedBorderColor;
  final Color? selectedContentColor;
  final Color? unselectedContentColor;
  final double borderRadius;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    // Dynamic color resolution with Fallbacks based on Theme
    final effectiveSelectedBg =
        selectedBackgroundColor ?? primaryColor;
    final effectiveUnselectedBorder = unselectedBorderColor ??
        theme.colorScheme.onSurface.withValues(alpha: 0.15);
    final effectiveSelectedContent =
        selectedContentColor ?? Colors.white;
    final effectiveUnselectedContent = unselectedContentColor ??
        theme.colorScheme.onSurface.withValues(alpha: 0.7);

    final currentContentColor = isSelected
        ? effectiveSelectedContent
        : effectiveUnselectedContent;

    return AnimatedScale(
      scale: isSelected ? 1.02 : 1.0,
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOutCubic,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius.r),
          onTap: onTap,
          splashColor: primaryColor.withValues(alpha: 0.1),
          highlightColor: Colors.transparent,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            curve: Curves.fastOutSlowIn,
            padding: padding ??
                REdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: isSelected
                  ? effectiveSelectedBg
                  : theme.colorScheme.surface.withValues(alpha: 0.6),
              borderRadius: BorderRadius.circular(borderRadius.r),
              border: Border.all(
                color: isSelected
                    ? effectiveSelectedBg
                    : effectiveUnselectedBorder,
                width: isSelected ? 1.8 : 1.2,
              ),
              boxShadow: isSelected
                  ? [
                      BoxShadow(
                        color: effectiveSelectedBg.withValues(alpha: 0.35),
                        blurRadius: 12,
                        spreadRadius: 1,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.02),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ...[
                  Icon(
                    categoryDM.icon,
                    color: currentContentColor,
                    size: 18.sp,
                  ),
                  SizedBox(width: 8.w),
                ],

                Text(
                  categoryDM.name,
                  style: theme.textTheme.titleSmall?.copyWith(
                    decoration: TextDecoration.none,
                    color: currentContentColor,
                    fontWeight:
                        isSelected ? FontWeight.w700 : FontWeight.w500,
                    fontSize: 13.sp,
                    letterSpacing: 0.3,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}