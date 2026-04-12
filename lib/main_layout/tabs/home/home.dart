import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/main_layout/tabs/home/widgets/evenItem.dart';
import 'package:evently/main_layout/tabs/home/widgets/tab_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../../core/resources/constant_data/constant_data.dart';
import '../../../core/resources/icons/icons_manager.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(bottom: Radius.circular(26.r)),
            ),
            child: SafeArea(
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome Back ✨",
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                    Text(
                      "Mohamed Waleed",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 8.h),

                    Row(
                      children: [
                        SvgPicture.asset(IconsManager.mapOutlined),
                        SizedBox(width: 6.w),
                        Text(
                          "Cairo, Egypt",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
                    ),

                    SizedBox(height: 24.h),

                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: ConstantManager.categoriesWithAll.length,
                        itemBuilder: (context, index) {
                          final category = ConstantManager.categoriesWithAll[index];

                          return Padding(
                            padding: EdgeInsets.only(right: 8.w),
                            child: CustomTabItem(
                              categoryDM: category,
                              unselectedBorderColor: ColorsManager.offWhite,

                              isSelected: selectedIndex == index,
                              onTap: () {
                                setState(() {
                                  selectedIndex = index;
                                });
                              },
                            ),
                          );
                        },
                      ),
                    ),

                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(12.w),
              itemCount: ConstantManager.events.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 12.h),
                  child: EventCard(
                    event: ConstantManager.events[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
