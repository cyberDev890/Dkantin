// import 'package:geocoding/geocoding.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var locationMessage = "Belum mendapatkan Lat dan Long".obs;
  var addressMessage = "Mencari lokasi".obs;
  var textEditingController = TextEditingController().obs;
  var myPosition = Position(
    altitudeAccuracy: 0,
    headingAccuracy: 0,
    longitude: 0,
    latitude: 0,
    timestamp: DateTime.now(),
    accuracy: 0,
    altitude: 0.0,
    heading: 0,
    speed: 0,
    speedAccuracy: 0,
  ).obs;
  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

 
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission locationPermission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error("Location service belum aktif");
    }

    locationPermission = await Geolocator.checkPermission();
    if (locationPermission == LocationPermission.denied) {
      locationPermission = await Geolocator.requestPermission();
      if (locationPermission == LocationPermission.denied)
        return Future.error("Location Permission ditolak");
    }

    if (locationPermission == LocationPermission.deniedForever)
      return Future.error(
          "Location permission ditolak, gagal request permissions");

    Position position = await Geolocator.getCurrentPosition();
    myPosition.value = position;
  }

  Future<void> getAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    Placemark place = placemarks[0];
    addressMessage.value =
        "${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country} ";
  }
}
