import 'package:evently/features/tabs/home/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../DM/CategoryDM.dart';
import '../cubit/home_cubit.dart';

class CategoryFilterTabs extends StatelessWidget {
  final List<CategoryDM> categories;

  const CategoryFilterTabs({
    super.key,
    required this.categories,
  });

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
            padding: REdgeInsets.symmetric(horizontal: 16),
            itemCount: categories.length,
            separatorBuilder: (_, _) => SizedBox(width: 10.w),
            itemBuilder: (context, index) {
              final category = categories[index];
              final isSelected = state.selectedCategoryIndex == index;

              return CustomTabItem(
                key: ValueKey(category.id),
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
              );
            },
          ),
        );
      },
    );
  }
}