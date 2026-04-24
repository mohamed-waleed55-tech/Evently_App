import 'package:flutter/material.dart';
import 'package:location/location.dart';

class LocationMapProvider extends ChangeNotifier{
  LocationMapProvider(){
    getLocation();
  }
  Location location=Location();
  String locationMessage="";
  Future<void> getLocation() async {
    bool permissionGranted= await _getLocationPermission();
    if(!permissionGranted){
      locationMessage="Location permission denied";
      notifyListeners();
      return;

    }
    bool serviceEnabled=await _checkLocationService();

    if(!serviceEnabled){
      locationMessage="Location service disabled";
      notifyListeners();
      return;
    }
    LocationData locationData=await location.getLocation();
    locationMessage="Latitude: ${locationData.latitude}, Longitude: ${locationData.longitude}";
    notifyListeners();


  }

  Future<bool> _getLocationPermission() async{
    PermissionStatus permissionStatus;
    permissionStatus= await location.hasPermission();
    if(permissionStatus==PermissionStatus.denied){
      permissionStatus= await location.requestPermission();
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
  }


