
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/resources/constant_data/constant_data.dart';
import '../cubit/home_cubit.dart';
import '../widgets/evenItem.dart';
import '../widgets/home_header.dart';
import '../widgets/tab_item.dart';
class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final categoriesWithAll = ConstantManager.getCategoriesWithAll(context);

    return BlocProvider(
      create: (context) => HomeCubit()..getEvents(categoriesWithAll[0].id, 0),
      child: Scaffold(
        body: Column(
          children: [
            _buildHeader(context, categoriesWithAll),
            Expanded(child: _buildEventsList()),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context, List categoriesWithAll) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(26.r)),
      ),
      child: Padding(
        padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 20.h),
        child: Column(
          children: [
            HomeHeader(),
            SizedBox(height: 14.h),
            _buildCategoryTabs(categoriesWithAll),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryTabs(List categoriesWithAll) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        return SizedBox(
          height: 40,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: categoriesWithAll.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: EdgeInsets.only(right: 8.w),
                child: CustomTabItem(
                  categoryDM: categoriesWithAll[index],
                  isSelected: state.selectedCategoryIndex == index,
                  onTap: () => context.read<HomeCubit>().getEvents(
                    categoriesWithAll[index].id,
                    index,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildEventsList() {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state.status == HomeStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state.status == HomeStatus.failure) {
          return Center(child: Text(state.errorMessage ?? "Error"));
        }
        if (state.events.isEmpty) {
          return const Center(child: Text("No events found"));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: state.events.length,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: EventCard(event: state.events[index]),
          ),
        );
      },
    );
  }

}