import 'package:evently/DM/eventDM.dart';
import 'package:evently/features/events/details/widgets/event_details_card.dart';
import 'package:evently/features/tabs/map/provider/location_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class EventMapView extends StatelessWidget {
  final EventDM? event;

  const EventMapView({
    super.key,
    this.event,
  });

  static const LatLng _defaultLocation = LatLng(30.0444, 31.2357);

  @override
  Widget build(BuildContext context) {
    final initialTarget = (event?.lat != null && event?.lng != null)
        ? LatLng(event!.lat!, event!.lng!)
        : _defaultLocation;

    return ChangeNotifierProvider(
      create: (_) => LocationMapProvider(),
      child: Scaffold(
        body: Consumer<LocationMapProvider>(
          builder: (context, provider, child) {
            return Stack(
              children: [
                GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: initialTarget,
                    zoom: 14.5,
                  ),
                  markers: provider.markers,
                  onMapCreated: (controller) {
                    provider.googleMapController = controller;
                  },
                ),

                if (event != null)
                  Positioned(
                    left: 16,
                    right: 16,
                    bottom: 24,
                    child: EventDetailsCard(
                      event: event,
                    ),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}