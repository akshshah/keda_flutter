import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/base_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:keda_flutter/utils/credentials.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:http/http.dart' as http;

import '../utils/channel/platform_channel.dart';
import '../utils/logger.dart';


class AddressProvider extends BaseBloc with ChangeNotifier{

  CameraPosition myPosition = const CameraPosition(
    target: LatLng(21.208667, 72.839278),
    zoom: 18,
  );

  final TextEditingController locationController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  final Permission _permission = Permission.location;
  Completer<GoogleMapController> controller = Completer();

  LatLng lastMapPosition = const LatLng(21.208667,  72.839278);
  // Marker myMarker = const Marker(markerId: MarkerId("m1"), position: LatLng(21.208667,  72.839278));

  void checkPermission() async {
    var ans = await PlatformChannel().checkForPermission(_permission);
    Logger().d("Result $ans");
    if(ans == true){
      GoogleMapController _controller = await controller.future;
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      myPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18,);
      lastMapPosition = LatLng(myPosition.target.latitude,  myPosition.target.longitude);
      _controller.animateCamera(CameraUpdate.newCameraPosition(myPosition));
      notifyListeners();
      getAddressByLatLong();
    }
  }

  void selectLocation(LatLng position){
    // myMarker = Marker(markerId: const MarkerId("m1"), position: position);
    lastMapPosition = position;
    notifyListeners();
    getAddressByLatLong();
  }

  Future<void> gotoCurrentLocation() async {
    var ans = await PlatformChannel().checkForPermission(_permission);
    Logger().d("Result $ans");
    if(ans == true){
      final GoogleMapController _controller = await controller.future;
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      CameraPosition _currentPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18,);
      _controller.animateCamera(CameraUpdate.newCameraPosition(_currentPosition));
      lastMapPosition =  LatLng(_currentPosition.target.latitude,  _currentPosition.target.longitude);
      getAddressByLatLong();
    }
    notifyListeners();
  }

  void getAddressByLatLong() async {
    // List<Placemark> placemarks = await placemarkFromCoordinates(lastMapPosition.latitude, lastMapPosition.longitude);
    // Placemark placemark = placemarks[0];
    // Logger().d(placemark.toString());
    // String? name = placemark.name ?? placemark.street;
    // String? locality = placemark.subLocality ?? placemark.locality;
    // String? administrativeArea = placemark.administrativeArea;
    // String? subAdministrativeArea = placemark.subAdministrativeArea;
    // String? country = placemark.country;
    // String? postalCode = placemark.postalCode;
    //
    //
    // String? address = "$name, $locality, $subAdministrativeArea, $administrativeArea $postalCode, $country, ";
    // locationController.text = address;


    final url = 'https://maps.googleapis.com/maps/api/geocode/json?latlng=${lastMapPosition.latitude},${lastMapPosition.longitude}&key=${Credentials.API_KEY}';
    final response = await http.get(Uri.parse(url));
    final address = await jsonDecode(response.body)['results'][0]["formatted_address"];
    locationController.text = address;
    notifyListeners();
  }

  Future<void> displayPrediction(Prediction? p, BuildContext context) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: Credentials.API_KEY,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry?.location.lat;
      final lng = detail.result.geometry?.location.lng;

      if(lat != null && lng != null){
        final GoogleMapController _controller = await controller.future;
        CameraPosition _currentPosition = CameraPosition(target: LatLng(lat, lng), zoom: 18,);
        _controller.animateCamera(CameraUpdate.newCameraPosition(_currentPosition));
        searchController.text = detail.result.name;
        lastMapPosition = LatLng(lat, lng);
        getAddressByLatLong();
        FocusScope.of(context).unfocus();
        notifyListeners();
      }
    }
  }

}