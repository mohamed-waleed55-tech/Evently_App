import 'package:evently/core/resources/constant_data/constant_data.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../../DM/eventDM.dart';
import '../../../../../core/extesions/getMonthNameExFun.dart';
import '../../../../../core/firebase_service/firestore/firestore_service.dart';
import '../../../../../core/resources/routes/routes_manager.dart';
import '../../profile/provider/config_provider.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final EventDM event;

  @override
  Widget build(BuildContext context) {
    final configProvider = context.watch<ConfigProvider>();
    final currentUserId = FirebaseAuth.instance.currentUser?.uid;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return Container(
      margin: REdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 16,
            spreadRadius: 0,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(24.r),
          onTap: () {
            Navigator.pushNamed(
              context,
              RoutesManager.eventDetails,
              arguments: event,
            );
          },
          child: Container(
            height: 220.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24.r),
              image: DecorationImage(
                image: AssetImage(
                  _getCategoryImgPath(
                      context, configProvider.isLight, event.category),
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              // Gradient Overlay لتحسين قراءة النصوص والرموز فوق الخلفية
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24.r),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withValues(alpha: 0.25),
                    Colors.black.withValues(alpha: 0.65),
                  ],
                ),
              ),
              padding: REdgeInsets.all(14),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Top Row: Date Badge + Category Tag
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Modern Glassmorphism Date Badge
                      Container(
                        padding: REdgeInsets.symmetric(
                            vertical: 6, horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.85),
                          borderRadius: BorderRadius.circular(14.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.4),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.1),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              event.dateTime.day.toString(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 18.sp,
                                fontWeight: FontWeight.w900,
                                height: 1.0,
                              ),
                            ),
                            SizedBox(height: 2.h),
                            Text(
                              event.dateTime.getMonth.substring(0, 3).toUpperCase(),
                              style: TextStyle(
                                color: primaryColor,
                                fontSize: 11.sp,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Category Pill Badge
                      Container(
                        padding: REdgeInsets.symmetric(
                            horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.4),
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: Colors.white.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Text(
                          event.category.toUpperCase(),
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.8,
                          ),
                        ),
                      ),
                    ],
                  ),

                  // Bottom Floating Info Bar
                  Container(
                    width: double.infinity,
                    padding: REdgeInsets.symmetric(
                        horizontal: 14, vertical: 10),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .surface
                          .withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(16.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.15),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Event Title
                        Expanded(
                          child: Text(
                            event.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context)
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15.sp,
                                ),
                          ),
                        ),

                        SizedBox(width: 8.w),

                        // Animated Favorite Button Stream
                        if (currentUserId != null)
                          StreamBuilder<List<String>>(
                            stream:
                                FirestoreService.getFavStreamIds(currentUserId),
                            builder: (context, snapshot) {
                              final favList = snapshot.data ?? [];
                              final isFav = favList.contains(event.id);

                              return Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  borderRadius: BorderRadius.circular(20.r),
                                  onTap: () async {
                                    await FirestoreService.toggleFavorite(
                                        event.id);
                                  },
                                  child: AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    padding: REdgeInsets.all(6),
                                    decoration: BoxDecoration(
                                      color: isFav
                                          ? primaryColor.withValues(alpha: 0.12)
                                          : Colors.transparent,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      isFav
                                          ? Icons.favorite_rounded
                                          : Icons.favorite_border_rounded,
                                      color: primaryColor,
                                      size: 22.sp,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _getCategoryImgPath(
    BuildContext context,
    bool isLight,
    String categoryId,
  ) {
    final categories = ConstantManager.getCategories(context);
    for (final category in categories) {
      if (category.id == categoryId) {
        return isLight ? category.lightImgPath : category.darkImgPath;
      }
    }
    return "";
  }
}