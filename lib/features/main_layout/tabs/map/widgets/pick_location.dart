
import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:evently/features/main_layout/tabs/map/provider/location_map.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' ;


class PickLocation extends StatefulWidget {
  const PickLocation({super.key});

  @override
  State<PickLocation> createState() => _PickLocationState();
}

class _PickLocationState extends State<PickLocation> {
  LatLng? _pickedLatLng;
  final Set<Marker> _pickedMarkers = {};

  void _popWithResult() {
    Navigator.pop(context, _pickedLatLng);
  }

  @override
  Widget build(BuildContext context) {
    final locationMapProvider = Provider.of<LocationMapProvider>(context);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (!didPop) _popWithResult();
      },
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              child: GoogleMap(
                initialCameraPosition: LocationMapProvider.cameraPosition,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                onMapCreated: (controller) {
                  locationMapProvider.googleMapController = controller;
                  locationMapProvider.getLocation();
                },
                onTap: (position) {
                  setState(() {
                    _pickedLatLng = position;
                    _pickedMarkers
                      ..clear()
                      ..add(
                        Marker(
                          markerId: const MarkerId('picked_location'),
                          position: position,
                          infoWindow: const InfoWindow(
                            title: 'Picked Location',
                          ),
                        ),
                      );
                  });
                },
                markers: {...locationMapProvider.markers, ..._pickedMarkers},
                mapType: MapType.normal,
              ),
            ),
            InkWell(
              onTap: _pickedLatLng == null ? null : _popWithResult,
              child: Container(
                color: _pickedLatLng==null ?ColorsManager.gray:ColorsManager.blue,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                alignment: Alignment.center,
                child: Text(
                  _pickedLatLng == null ? "Tap on Location To Select" : "Confirm Location",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


}
