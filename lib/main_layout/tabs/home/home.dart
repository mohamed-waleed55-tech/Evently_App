import 'package:evently/DM/eventDM.dart';
import 'package:evently/DM/userDM.dart';
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/firebase_service/firestore/firestore_service.dart';
import 'package:evently/main_layout/tabs/home/widgets/evenItem.dart';
import 'package:evently/main_layout/tabs/home/widgets/tab_item.dart';
import 'package:evently/providers/config_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import '../../../core/resources/constant_data/constant_data.dart';
import '../../../core/resources/icons/icons_manager.dart';
import '../../../l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int selectedCategoryIndex = 0;

  @override
  Widget build(BuildContext context) {
    var configProvider = Provider.of<ConfigProvider>(context);
    final categoriesWithAll = ConstantManager.getCategoriesWithAll(context);
    return Container(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(26.r),
              ),
            ),
            child: Padding(
              padding: REdgeInsets.symmetric(horizontal: 16.0, vertical: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${AppLocalizations.of(context)!.welcome_back} ✨",
                            style: Theme.of(context).textTheme.headlineSmall
                                ?.copyWith(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w400,
                                ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            UserDM.currentUser?.name ?? "",
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Icon(
                              configProvider.isLight
                                  ? Icons.wb_sunny_outlined
                                  : Icons.dark_mode_outlined,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 14,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                            ),
                            child: Text(
                              configProvider.isEnglish ? "En" : "Ar",
                              style: TextStyle(
                                color: Colors.indigo,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
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
                      itemCount: categoriesWithAll.length,
                      itemBuilder: (context, index) {
                        final category = categoriesWithAll[index];

                        return Padding(
                          padding: EdgeInsets.only(right: 8.w),
                          child: CustomTabItem(
                            categoryDM: category,
                            unselectedBorderColor: ColorsManager.offWhite,

                            isSelected: selectedCategoryIndex == index,
                            onTap: () {
                              setState(() {
                                selectedCategoryIndex = index;
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
          StreamBuilder(
            stream: FirestoreService.getEventsStream(categoriesWithAll[selectedCategoryIndex].id),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (snapshot.hasError) {
                return Center(child: Text(snapshot.error.toString()));
              }

              final events = snapshot.data ?? [];
              if (events.isEmpty) {
                return Expanded(
                  child: Center(
                    child: Text("No events found",style: Theme.of(context).textTheme.labelMedium,),
                  ),
                );
              }

              return Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(12),
                  itemCount: events.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: EventCard(event: events[index]),
                    );
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
