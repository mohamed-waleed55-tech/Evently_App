import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../../../DM/eventDM.dart';
import '../../../../../core/extesions/getMonthNameExFun.dart';
import '../../../../../core/resources/colors/colors_manager.dart';
import '../../../../../core/resources/constant_data/constant_data.dart';
import '../../../tabs/map/provider/location_map.dart';
import '../../../tabs/profile/provider/config_provider.dart';
import 'map_review.dart';
import 'map_ui.dart';

class EventDetailsBody extends StatelessWidget {
  const EventDetailsBody({required this.event});
  final EventDM event;

  @override
  Widget build(BuildContext context) {
    final configProvider = context.watch<ConfigProvider>();
    final locationMapProvider = context.watch<LocationMapProvider>();

    locationMapProvider.convertLatLong(LatLng(event.lat ?? 0, event.lng ?? 0));

    final categories = ConstantManager.getCategories(context);
    final selectedCategory = categories.firstWhere(
          (c) => c.id == event.category,
      orElse: () => categories.first,
    );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
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
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.08),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: ColorsManager.blue.withOpacity(0.5),
              ),
            ),
            child: Text(
              event.title,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: ColorsManager.blue,
              ),
            ),
          ),

          const SizedBox(height: 16),

          InfoCard(
            icon: Icons.calendar_today,
            title: event.dateTime.toFormattedDate,
            subtitle: TimeOfDay.fromDateTime(event.dateTime).format(context),
          ),

          const SizedBox(height: 12),

          InfoCard(
            icon: Icons.location_on,
            title: locationMapProvider.city.isEmpty
                ? "Fetching location..."
                : "${locationMapProvider.city}, ${locationMapProvider.country}",
          ),

          const SizedBox(height: 16),

          MapPreview(
            lat: event.lat ?? 0,
            lng: event.lng ?? 0,
          ),

          const SizedBox(height: 16),

          Text(
            "Description",
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.bold,
              color: ColorsManager.blue,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            event.description,
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ],
      ),
    );
  }
}