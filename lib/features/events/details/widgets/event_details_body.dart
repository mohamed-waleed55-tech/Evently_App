import 'package:evently/features/tabs/map/screen/map.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../../../DM/eventDM.dart';
import '../../../../../core/extesions/getMonthNameExFun.dart';
import '../../../../../core/resources/constant_data/constant_data.dart';
import '../../../tabs/map/provider/location_map.dart';
import '../../../tabs/profile/provider/config_provider.dart';
import 'map_review.dart';

class EventDetailsBody extends StatefulWidget {
  const EventDetailsBody({super.key, required this.event});
  final EventDM event;

  @override
  State<EventDetailsBody> createState() => _EventDetailsBodyState();
}

class _EventDetailsBodyState extends State<EventDetailsBody> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        context.read<LocationMapProvider>().convertLatLong(
              LatLng(widget.event.lat ?? 0, widget.event.lng ?? 0),
            );
      }
    });
  }

  void _navigateToMapScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EventMapView(
          event: widget.event,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final configProvider = context.watch<ConfigProvider>();
    final locationMapProvider = context.watch<LocationMapProvider>();
    final primaryColor = Theme.of(context).primaryColor;
    final isDark = !configProvider.isLight;

    final categories = ConstantManager.getCategories(context);
    final selectedCategory = categories.firstWhere(
      (c) => c.id == widget.event.category,
      orElse: () => categories.first,
    );

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. HERO BANNER WITH FLOATING DATE BADGE
          Stack(
            clipBehavior: Clip.none,
            children: [
              // Event Image Preview
              Container(
                height: 200.h,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24.r),
                  child: Image.asset(
                    configProvider.isLight
                        ? selectedCategory.lightImgPath
                        : selectedCategory.darkImgPath,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              // Category Chip Tag
              Positioned(
                top: 16.h,
                left: 16.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.black.withValues(alpha: 0.7)
                        : Colors.white.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(30.r),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.category_rounded, size: 14.r, color: primaryColor),
                      SizedBox(width: 6.w),
                      Text(
                        selectedCategory.name,
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Floating Date Badge (Bottom Right)
              Positioned(
                bottom: -16.h,
                right: 20.w,
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.circular(16.r),
                    boxShadow: [
                      BoxShadow(
                        color: primaryColor.withValues(alpha: 0.35),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Text(
                        widget.event.dateTime.day.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                          height: 1,
                        ),
                      ),
                      Text(
                        widget.event.dateTime.toFormattedDate.split(' ').first,
                        style: TextStyle(
                          color: Colors.white.withValues(alpha: 0.85),
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 28.h),

          // 2. EVENT TITLE
          Text(
            widget.event.title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 22.sp,
                  height: 1.2,
                ),
          ),

          SizedBox(height: 20.h),

          // 3. INFORMATION CARDS SECTION
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.02),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                // Time & Date Row
                _buildModernDetailRow(
                  context,
                  icon: Icons.access_time_filled_rounded,
                  title: widget.event.dateTime.toFormattedDate,
                  subtitle: TimeOfDay.fromDateTime(widget.event.dateTime).format(context),
                  primaryColor: primaryColor,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 12.h),
                  child: Divider(
                    height: 1,
                    color: isDark ? Colors.grey.shade800 : Colors.grey.shade100,
                  ),
                ),
                // Location Row
                _buildModernDetailRow(
                  context,
                  icon: Icons.location_on_rounded,
                  title: locationMapProvider.city.isEmpty
                      ? "Fetching location..."
                      : "${locationMapProvider.city}, ${locationMapProvider.country}",
                  subtitle: "Event Location",
                  primaryColor: primaryColor,
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // 4. MAP PREVIEW SECTION
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Location Map",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp,
                    ),
              ),
              GestureDetector(
                onTap: () => _navigateToMapScreen(context),
                child: Text(
                  "Open Map",
                  style: TextStyle(
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 12.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 12.h),

          GestureDetector(
            onTap: () => _navigateToMapScreen(context),
            child: Container(
              height: 150.h,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.r),
                border: Border.all(
                  color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.r),
                child: AbsorbPointer(
                  child: MapPreview(
                    lat: widget.event.lat ?? 0,
                    lng: widget.event.lng ?? 0,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: 24.h),

          // 5. DESCRIPTION SECTION
          Text(
            "About Event",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                ),
          ),

          SizedBox(height: 8.h),

          Container(
            width: double.infinity,
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
              ),
            ),
            child: Text(
              widget.event.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: isDark ? Colors.grey[300] : Colors.grey[700],
                    height: 1.6,
                    fontSize: 13.5.sp,
                  ),
            ),
          ),

          SizedBox(height: 30.h),
        ],
      ),
    );
  }

  Widget _buildModernDetailRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    required String subtitle,
    required Color primaryColor,
  }) {
    return Row(
      children: [
        Container(
          height: 42.r,
          width: 42.r,
          decoration: BoxDecoration(
            color: primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: primaryColor, size: 22.r),
        ),
        SizedBox(width: 14.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 11.5.sp,
                  color: Colors.grey[500],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}