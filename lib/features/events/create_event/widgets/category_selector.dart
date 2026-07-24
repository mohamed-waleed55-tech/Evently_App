import 'package:evently/features/events/create_event/bloc/create_event_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategorySelector extends StatelessWidget {
  final List categories;
  final int selectedIndex;

  const CategorySelector({
    super.key,
    required this.categories,
    required this.selectedIndex,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 44.h,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        separatorBuilder: (_, __) => SizedBox(width: 8.w),
        itemBuilder: (context, index) {
          final isSelected = selectedIndex == index;
          final category = categories[index];

          return GestureDetector(
            onTap: () {
              context.read<CreateEventBloc>().add(CategoryChanged(index));
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              padding: REdgeInsets.symmetric(
                horizontal: isSelected ? 18 : 14,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected
                    ? colorScheme.primary
                    : colorScheme.surfaceContainerHigh,
                borderRadius: BorderRadius.circular(24.r),
                border: Border.all(
                  color: isSelected
                      ? colorScheme.primary
                      : colorScheme.outlineVariant.withOpacity(0.3),
                  width: 1.5,
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: colorScheme.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : [],
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    transitionBuilder: (child, animation) => ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                    child: isSelected
                        ? Padding(
                            key: const ValueKey('selected_icon'),
                            padding: REdgeInsets.only(left:  6),
                            child: Icon(
                              Icons.check_circle_rounded,
                              size: 16.r,
                              color: Colors.white,
                            ),
                          )
                        : const SizedBox.shrink(key: ValueKey('unselected')),
                  ),
                  AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 250),
                    style: TextStyle(
                      color: isSelected ? Colors.white : colorScheme.onSurface,
                      fontWeight:
                          isSelected ? FontWeight.bold : FontWeight.w500,
                      fontSize: isSelected ? 14.sp : 13.sp,
                      fontFamily: Theme.of(context).textTheme.bodyMedium?.fontFamily,
                    ),
                    child: Text(category.name),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}