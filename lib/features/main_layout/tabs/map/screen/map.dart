import 'package:evently/core/resources/colors/colors_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' as gmap;
import 'package:provider/provider.dart';

import '../provider/location_map.dart';

class GoogleMap extends StatelessWidget {
  const GoogleMap({super.key});

  @override
  Widget build(BuildContext context) {
    final locationMapProvider = context.watch<LocationMapProvider>();

    return Scaffold(
      floatingActionButton: Padding(
        padding:  REdgeInsets.all(16.0),
        child: FloatingActionButton(onPressed: (){
          locationMapProvider.getLocation();
        },backgroundColor: ColorsManager.blue,foregroundColor: Colors.white,
          child: Icon(Icons.my_location),),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,

      body: Column(
        children: [
          Expanded(
            child: gmap.GoogleMap(
              initialCameraPosition: LocationMapProvider.cameraPosition,
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              onMapCreated: (controller) {
                locationMapProvider.googleMapController =controller;
                locationMapProvider.getLocation();
              },
              markers: locationMapProvider.markers,
              mapType: gmap.MapType.normal ,
            ),
          ),
        ],
      ),
    );
  }
}
