import 'package:evently/DM/eventDM.dart';
import 'package:evently/DM/userDM.dart';
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/core/resources/images/images_manager.dart';
import 'package:evently/core/utils/dialog.dart';
import 'package:evently/extesions/getMonthNameExFun.dart';
import 'package:evently/main_layout/screens/details/widgets/map_review.dart';
import 'package:evently/main_layout/screens/details/widgets/map_ui.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/resources/constant_data/constant_data.dart';
import '../../../core/resources/routes/routes_manager.dart';
import '../../../firebase_service/firestore/firestore_service.dart';
import '../../../providers/config_provider.dart';

class EventDetails extends StatefulWidget {
  const EventDetails({super.key, required this.event});

  final EventDM event;

  @override
  State<EventDetails> createState() => _EventDetailsState();
}

class _EventDetailsState extends State<EventDetails> {
  late ConfigProvider configProvider = Provider.of<ConfigProvider>(context);

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final categories = ConstantManager.getCategories(context);

    int selectedIndex = categories.indexWhere(
          (c) => c.id == widget.event.category,
    );
    final selectedCategory = categories[selectedIndex];
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: ColorsManager.blue),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text("Event Details"),
        actions: UserDM.currentUser!.id == widget.event.createdById
            ? [
          IconButton(
            onPressed: editEvent,
            icon: const Icon(
              Icons.edit_note_outlined,
              color: ColorsManager.blue,
            ),
          ),
          IconButton(
            onPressed: deleteEvent,
            icon: const Icon(
              Icons.delete_outline_outlined,
              color: ColorsManager.blue,
            ),
          ),
        ]
            : [],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,

          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                configProvider.isLight
                    ? selectedCategory.lightImgPath
                    : selectedCategory.darkImgPath,
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            const SizedBox(height: 16),

            Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                  color: ColorsManager.blue.withValues(alpha: 0.5),
                ),
              ),
              child: Text(
                widget.event.title,
                textAlign: TextAlign.center,
                maxLines: 2, // or 3
                overflow: TextOverflow.ellipsis,
                softWrap: true,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: ColorsManager.blue,
                ),
              ),
            ),


            const SizedBox(height: 16),

            InfoCard(
              icon: Icons.calendar_today,
              title: widget.event.dateTime.date,
              subtitle: widget.event.dateTime.time,
            ),

            const SizedBox(height: 12),

            InfoCard(icon: Icons.location_on, title: "Cairo, Egypt"),

            const SizedBox(height: 16),

            MapPreview(),

            const SizedBox(height: 16),

            Text(
              "Description",
              style: Theme
                  .of(context)
                  .textTheme
                  .labelSmall
                  ?.copyWith(
                fontWeight: FontWeight.bold,
                color: ColorsManager.blue,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              widget.event.description,
              style: Theme
                  .of(context)
                  .textTheme
                  .labelSmall,
            ),
          ],
        ),
      ),
    );
  }

  void editEvent() {
    Navigator.pushNamed(
      context,
      RoutesManager.updateEvent,
      arguments: widget.event,
    );
  }

  void deleteEvent() async {
    DialogUtils.showMessage(
        context, message: "Are you sure you want to delete this event?",
        title: "Delete Event",
        posActionTitle: "Delete", posAction: () async {
      await FirestoreService.deleteEvent(widget.event.id);
      await FirestoreService.removeEventFromFav(widget.event.id);
      if (!mounted) return;
      Navigator.pop(context);
    }, negActionTitle: "Cancel", negAction: () {});
  }
}
