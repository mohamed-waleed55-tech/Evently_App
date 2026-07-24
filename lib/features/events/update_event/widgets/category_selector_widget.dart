import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../DM/CategoryDM.dart';
import '../../../tabs/home/widgets/tab_item.dart';

class CategorySelectorWidget extends StatelessWidget {
  const CategorySelectorWidget({
    super.key,
    required this.categories,
    required this.selectedIndex,
    required this.onCategorySelected,
  });

  final List<CategoryDM> categories;
  final int selectedIndex;
  final ValueChanged<int> onCategorySelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: CustomTabItem(
              categoryDM: categories[index],
              isSelected: selectedIndex == index,
              selectedBackgroundColor: theme.primaryColor,
              selectedContentColor: theme.colorScheme.onPrimary,
              unselectedContentColor: theme.primaryColor,
              unselectedBorderColor: theme.primaryColor,
              onTap: () => onCategorySelected(index),
            ),
          );
        },
      ),
    );
  }
}