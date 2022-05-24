import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:keda_flutter/ui/bottomNavigation/settingsModule/screens/TestScreen.dart';
import 'package:keda_flutter/utils/channel/platform_channel.dart';
import 'package:keda_flutter/utils/logger.dart';
import 'package:keda_flutter/utils/mixin/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/ui_text_style.dart';

const kGoogleApiKey = "AIzaSyArUb_knFUpQu2xGRXgt974tW2eXATwV1w";

class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  static const routeName = "/add-address-screen";

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _AddAddressScreenState extends State<AddAddressScreen> {
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  final Permission _permission = Permission.location;
  bool isHome = false;
  bool isWork = false;
  bool isOther = false;

  @override
  void initState() {
    super.initState();
    checkPermission();
  }

  void checkPermission() async {
    var ans = await PlatformChannel().checkForPermission(_permission);
    Logger().d("Result $ans");
    if(ans == true){
      final GoogleMapController controller = await _controller.future;
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _myPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18,);
      controller.animateCamera(CameraUpdate.newCameraPosition(_myPosition));
      _getAddressByLatLong();
    }
  }

  Future<void> _gotoCurrentLocation() async {
    var ans = await PlatformChannel().checkForPermission(_permission);
    Logger().d("Result $ans");
    if(ans == true){
      final GoogleMapController controller = await _controller.future;
      var position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      CameraPosition _currentPosition = CameraPosition(target: LatLng(position.latitude, position.longitude), zoom: 18,);
      controller.animateCamera(CameraUpdate.newCameraPosition(_currentPosition));
      _getAddressByLatLong();
    }
  }

  static CameraPosition _myPosition = const CameraPosition(
    target: LatLng(21.208667, 72.839278),
    zoom: 18,
  );

  LatLng _lastMapPosition =
      LatLng(_myPosition.target.latitude, _myPosition.target.longitude);

  void _onCameraMove(CameraPosition position) {
    _lastMapPosition = position.target;
    _getAddressByLatLong();
  }

  void _getAddressByLatLong() async {
    List<Placemark> placemarks = await placemarkFromCoordinates(_lastMapPosition.latitude, _lastMapPosition.longitude);
    Placemark placemark = placemarks[0];
    Logger().d(placemark.toString());
    String? name = placemark.name ?? placemark.street;
    String? locality = placemark.subLocality ?? placemark.locality;
    String? administrativeArea = placemark.administrativeArea;
    String? subAdministrativeArea = placemark.subAdministrativeArea;
    String? country = placemark.country;
    String? postalCode = placemark.postalCode;


    String? address = "$name, $locality, $subAdministrativeArea, $administrativeArea $postalCode, $country, ";
    _locationController.text = address;
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: Mode.overlay,
      types: [],
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "us")],
      strictbounds: false,
    );

    displayPrediction(p);
  }

  void onError(PlacesAutocompleteResponse response) {

    ScaffoldMessenger.of(homeScaffoldKey.currentState?.context ?? context).showSnackBar(
      SnackBar(content: Text(response.errorMessage ?? "")),
    );
  }

  Future<void> displayPrediction(Prediction? p) async {
    if (p != null) {
      // get detail (lat/lng)
      GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await const GoogleApiHeaders().getHeaders(),
      );
      PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId!);
      final lat = detail.result.geometry?.location.lat;
      final lng = detail.result.geometry?.location.lng;

      if(lat != null && lng != null){
        final GoogleMapController controller = await _controller.future;
        CameraPosition _currentPosition = CameraPosition(target: LatLng(lat, lng), zoom: 18,);
        controller.animateCamera(CameraUpdate.newCameraPosition(_currentPosition));
        _searchController.text = detail.result.name;
        _lastMapPosition = LatLng(lat, lng);
        _getAddressByLatLong();
      }

    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorPrimary,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Select Location"),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Divider(
                height: 2,
                color: AppColor.dark_sky_blue,
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 0.50.sh,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      GoogleMap(
                        mapType: MapType.normal,
                        compassEnabled: true,
                        initialCameraPosition: _myPosition,
                        onMapCreated: (GoogleMapController controller) {
                          _controller.complete(controller);
                        },
                        onCameraMove: _onCameraMove,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: false,
                        gestureRecognizers: Set()
                          ..add(Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()))
                          ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                          ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                          ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                          ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                      ),
                      Positioned(
                        left: 10,
                        right: 10,
                        top: 5,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 2, horizontal: 10),
                          decoration: BoxDecoration(
                            color: AppColor.whiteColor,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: kElevationToShadow[2],
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.search,
                                color: AppColor.gray,
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: "Search Address",
                                    border: InputBorder.none,
                                  ),
                                  onTap: ( () {
                                    _handlePressButton();
                                  }),
                                  controller: _searchController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                          right: 15,
                          bottom: 15,
                          child: IconButton(
                            icon: const Icon(
                              Icons.gps_fixed_rounded,
                              size: 40,
                            ),
                            onPressed: () {
                              _gotoCurrentLocation();
                            },
                            color: AppColor.colorPrimary,
                          )),
                      const Align(
                          alignment: Alignment.center,
                          child: Icon(
                            IcoFontIcons.locationPin,
                            size: 40,
                            color: AppColor.colorPrimary,
                          )),
                    ],
                  ),
                ),
                Container(
                  height: 0.40.sh,
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppColor.gray,
                        offset: Offset(
                          5.0,
                          5.0,
                        ),
                        blurRadius: 10.0,
                        spreadRadius: 2.0,
                      ), //BoxShadow
                      BoxShadow(
                        color: Colors.white,
                        offset: Offset(0.0, 0.0),
                        blurRadius: 0.0,
                        spreadRadius: 0.0,
                      ), //BoxShadow
                    ],
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(15, 16, 15, 0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            IconButton(
                              constraints: const BoxConstraints(),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.close,
                                color: AppColor.heading_text,
                              ),
                              padding: EdgeInsets.zero,
                            ),
                            Expanded(
                              child: Text(
                                "Select Type",
                                style: UITextStyle.semiBoldTextStyle(
                                    fontSize: 18),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: "Done",
                                  style: UITextStyle.semiBoldTextStyle(
                                      fontSize: 16),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {},
                                )
                              ],),),
                          ],
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: AppColor.heading_text_08,
                      ),
                      Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CommonWidget.createTextField(
                                labelText: "Location",
                                maxLines: 2,
                                controller: _locationController
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              CommonWidget.createTextField(
                                labelText: "Apartment/Suite #",
                              ),
                              const SizedBox(height: 20,),
                              Text("Save As", style: UITextStyle.semiBoldTextStyle(),),
                              const SizedBox(height: 10,),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton.icon(
                                    onPressed: () {
                                      setState((){
                                        isWork = false;
                                        isHome = true;
                                        isOther = false;
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: isHome ? AppColor.heading_text : AppColor.heading_text_50),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                    icon: Icon(Icons.home_outlined, color: isHome ? AppColor.heading_text : AppColor.heading_text_50),
                                    label: Text("Home", style: UITextStyle.regularTextStyle(color: isHome ? AppColor.heading_text : AppColor.heading_text_50),),
                                  ),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: isWork ? AppColor.heading_text : AppColor.heading_text_50),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                    onPressed: () {
                                      setState((){
                                        isWork = true;
                                        isHome = false;
                                        isOther = false;
                                      });
                                    },
                                    icon: Icon(Icons.work_outline_rounded, color: isWork ? AppColor.heading_text : AppColor.heading_text_50),
                                    label: Text("Work", style: UITextStyle.regularTextStyle(color: isWork ? AppColor.heading_text : AppColor.heading_text_50),),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      setState((){
                                        isWork = false;
                                        isHome = false;
                                        isOther = true;
                                      });
                                    },
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: isOther ? AppColor.heading_text : AppColor.heading_text_50),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                    icon: Icon(Icons.pin_drop_outlined, color: isOther ? AppColor.heading_text : AppColor.heading_text_50),
                                    label: Text("Other", style: UITextStyle.regularTextStyle(color: isOther ? AppColor.heading_text : AppColor.heading_text_50),),
                                  ),
                                ],
                              ),
                            ],
                          )
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
