
import 'package:evently/features/tabs/home/cubit/home_cubit.dart';
import 'package:evently/features/tabs/home/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CategoryFilterTabs extends StatelessWidget {
  final List<dynamic> categories;

  const CategoryFilterTabs({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          previous.selectedCategoryIndex != current.selectedCategoryIndex,
      builder: (context, state) {
        return SizedBox(
          height: 48.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            padding: REdgeInsets.symmetric(horizontal: 16.w),
            itemCount: categories.length,
            separatorBuilder: (_, _) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = state.selectedCategoryIndex == index;

              return AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                switchInCurve: Curves.easeInQuad,
                switchOutCurve: Curves.easeOutQuad,
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(
                    opacity: animation,
                    child: ScaleTransition(
                      scale: animation,
                      child: child,
                    ),
                  );
                },
                child: CustomTabItem(
                  key: ValueKey<int>(index == state.selectedCategoryIndex ? index : -index - 1),
                  categoryDM: category,
                  isSelected: isSelected,
                  onTap: () {
                    if (!isSelected) {
                      context.read<HomeCubit>().getEvents(
                            category.id,
                            index,
                          );
                    }
                  },
                ),
              );
            },
          ),
        );
      },
    );
  }
}
