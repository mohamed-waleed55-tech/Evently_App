import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/extesions/getMonthNameExFun.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../DM/eventDM.dart';

class EventCard extends StatelessWidget {
  const EventCard({super.key, required this.event});

  final EventDM event;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 205.h,
      width: 362.w,
      padding: REdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorsManager.blue, width: 2),
        image: DecorationImage(
          image: AssetImage(event.imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: REdgeInsets.symmetric(vertical: 4, horizontal: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(event.dateTime.day.toString(), style: Theme.of(context).textTheme.labelMedium?.copyWith(
                  color: ColorsManager.blue,
                  fontWeight: FontWeight.w700
                )),
                Text(event.dateTime.getMonth.substring(0,3), style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: ColorsManager.blue,
                )),
              ],
            ),
          ),

          Container(
            padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.9),
              borderRadius: BorderRadius.circular(10.r),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    event.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
                Icon(
                  Icons.favorite_border,
                  color: ColorsManager.blue,
                  size: 24.sp,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

}
