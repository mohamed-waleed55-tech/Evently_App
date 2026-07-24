import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationMapProvider extends ChangeNotifier {
  LocationMapProvider() {
    getLocation();
  }

  GoogleMapController? googleMapController;
  
  StreamSubscription<LocationData>? _locationSubscription;

  Set<Marker> markers = {};
  String country = "";
  String city = "";

  static CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );
  
  Location location = Location();
  String locationMessage = "";

  Future<void> getLocation() async {
    bool permissionGranted = await _getLocationPermission();
    if (!permissionGranted) return;

    bool serviceEnabled = await _checkLocationService();
    if (!serviceEnabled) return;

    LocationData locationData = await location.getLocation();
    changeLocation(locationData);
    setLocationListener();
  }

  Future<bool> _getLocationPermission() async {
    PermissionStatus permissionStatus = await location.hasPermission();
    if (permissionStatus == PermissionStatus.denied) {
      permissionStatus = await location.requestPermission();
    }
    return permissionStatus == PermissionStatus.granted;
  }

  Future<bool> _checkLocationService() async {
    bool serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
    }
    return serviceEnabled;
  }

  void changeLocation(LocationData locationData) {
    cameraPosition = CameraPosition(
      target: LatLng(locationData.latitude ?? 0, locationData.longitude ?? 0),
      zoom: 14.4746,
    );

    markers = {
      Marker(
        markerId: const MarkerId("currentLocation"),
        position: LatLng(
          locationData.latitude ?? 0,
          locationData.longitude ?? 0,
        ),
        infoWindow: const InfoWindow(
          title: "Current Location",
          snippet: "You are here",
        ),
      ),
    };

    // ✅ الآن أصبح الآمان تاماً: إذا لم تكتمل تهيئة الـ Controller فلن يحدث Crash
    googleMapController?.animateCamera(
      CameraUpdate.newCameraPosition(cameraPosition),
    );

    notifyListeners(); // تم نقلها هنا لتحديث الـ UI بالـ Markers و الكاميرا
  }

  void setLocationListener() {
    location.changeSettings(
      accuracy: LocationAccuracy.high,
      interval: 1000,
    );
    
    // حفظ الاشتراك في متغير للإلغاء لاحقاً
    _locationSubscription = location.onLocationChanged.listen((LocationData currentLocation) {
      changeLocation(currentLocation);
    });
  }

  Future<void> convertLatLong(LatLng latLng) async {
    try {
      final placemarks = await geocoding.placemarkFromCoordinates(
        latLng.latitude,
        latLng.longitude,
      );

      if (placemarks.isNotEmpty) {
        country = placemarks.first.country ?? 'Cannot find country';
        city = placemarks.first.locality ?? 'Cannot find city';
      } else {
        country = 'Cannot find country';
        city = 'Cannot find city';
      }
    } catch (e) {
      country = 'Cannot find country';
      city = 'Cannot find city';
    }

    notifyListeners();
  }

  static Future<LocationData?> getCurrentLocation() async {
    Location location = Location();
    return await location.getLocation();
  }

  @override
  void dispose() {
    _locationSubscription?.cancel(); 
    googleMapController?.dispose();
    super.dispose();
  }
}