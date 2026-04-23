import 'package:evently/DM/CategoryDM.dart';
import 'package:evently/DM/userDM.dart';
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/core/resources/constant_data/constant_data.dart';
import 'package:evently/extesions/getMonthNameExFun.dart';
import 'package:evently/firebase_service/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import '../../../../DM/eventDM.dart';
import '../../../../providers/config_provider.dart';

class EventCard extends StatefulWidget {
  const EventCard({super.key, required this.event});

  final EventDM event;

  @override
  State<EventCard> createState() => _EventCardState();
}

class _EventCardState extends State<EventCard> {
  late var configProvider;
  final userId = FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);

    return Container(
      height: 205.h,
      width: 362.w,
      padding: REdgeInsets.symmetric(vertical: 16, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: ColorsManager.blue, width: 2),
        image: DecorationImage(
          image: AssetImage(getCategoryImgPath(widget.event.category)),
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
          Text(
            widget.event.dateTime.day.toString(),
            style: Theme
                .of(context)
                .textTheme
                .labelMedium
                ?.copyWith(
              color: ColorsManager.blue,
              fontWeight: FontWeight.w700,
            ),
          ),
          Text(
            widget.event.dateTime.getMonth.substring(0, 3),
            style: Theme
                .of(
              context,
            )
                .textTheme
                .bodySmall
                ?.copyWith(color: ColorsManager.blue),
          ),
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
              widget.event.title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: ColorsManager.black),
            ),
          ),

          StreamBuilder<List<String>>(
            stream: FirebaseAuth.instance.currentUser?.uid == null
                ? const Stream.empty()
                : FirestoreService.getFavStreamIds(
              FirebaseAuth.instance.currentUser!.uid,
            ),
            builder: (context, snapshot) {
              final favList = snapshot.data ?? [];

              final isFav = favList.contains(widget.event.id);

              return IconButton(
                onPressed: FirebaseAuth.instance.currentUser?.uid == null
                    ? null
                    : () async {
                  await FirestoreService.toggleFavorite(widget.event.id);
                },
                icon: Icon(
                  isFav ? Icons.favorite : Icons.favorite_border,
                  color: ColorsManager.blue,
                ),
              );
            },
          ),
        ],
      ),
    ),
    ],
    )
    ,
    );
  }

  String getCategoryImgPath(String id) {
    List<CategoryDM> categories = ConstantManager.getCategories(context);
    for (CategoryDM category in categories) {
      if (category.id == id) {
        return configProvider.isLight
            ? category.lightImgPath
            : category.darkImgPath;
      }
    }
    return "";
  }
}
