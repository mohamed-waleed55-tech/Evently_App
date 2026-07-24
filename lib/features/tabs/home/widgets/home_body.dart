import 'package:evently/core/resources/constant_data/constant_data.dart';
import 'package:evently/features/tabs/home/widgets/category_filter_tabs.dart';
import 'package:evently/features/tabs/home/widgets/events.animated_list.dart';
import 'package:evently/features/tabs/home/widgets/home_header.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeBody extends StatefulWidget {
  const HomeBody({super.key});

  @override
  State<HomeBody> createState() => HomeBodyState();
}

class HomeBodyState extends State<HomeBody> with SingleTickerProviderStateMixin {
  late AnimationController _headerController;
  late Animation<Offset> _headerSlideAnimation;
  late Animation<double> _headerFadeAnimation;

  @override
  void initState() {
    super.initState();
    _headerController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    _headerSlideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeOutCubic,
    ));

    _headerFadeAnimation = CurvedAnimation(
      parent: _headerController,
      curve: Curves.easeIn,
    );

    _headerController.forward();
  }

  @override
  void dispose() {
    _headerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ConstantManager.getCategoriesWithAll(context);
    final theme = Theme.of(context);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        // Animated Floating Header
        SliverToBoxAdapter(
          child: SlideTransition(
            position: _headerSlideAnimation,
            child: FadeTransition(
              opacity: _headerFadeAnimation,
              child: Container(
                decoration: BoxDecoration(
                  color: theme.colorScheme.surface,
                  borderRadius: BorderRadius.vertical(
                    bottom: Radius.circular(28.r),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 16,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: SafeArea(
                  bottom: false,
                  child: Padding(
                    padding: REdgeInsets.only(top: 12.h, bottom: 20.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: REdgeInsets.symmetric(horizontal: 16.w),
                          child: const HomeHeader(),
                        ),
                        SizedBox(height: 18.h),
                        CategoryFilterTabs(categories: categories),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),

        SliverPadding(
          padding: REdgeInsets.fromLTRB(16.w, 20.h, 16.w, 16.h),
          sliver: const EventsAnimatedList(),
        ),
      ],
    );
  }
}