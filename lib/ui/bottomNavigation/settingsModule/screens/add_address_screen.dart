import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:keda_flutter/providers/add_address_screen_provider.dart';
import 'package:keda_flutter/utils/credentials.dart';
import 'package:keda_flutter/utils/mixin/common_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/ui_text_style.dart';


class AddAddressScreen extends StatefulWidget {
  const AddAddressScreen({Key? key}) : super(key: key);

  static const routeName = "/add-address-screen";

  @override
  State<AddAddressScreen> createState() => _AddAddressScreenState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _AddAddressScreenState extends State<AddAddressScreen> {
  bool isHome = false;
  bool isWork = false;
  bool isOther = false;
  late AddressProvider addressProvider;

  @override
  void initState() {
    super.initState();
    addressProvider = Provider.of<AddressProvider>(context, listen: false);
    addressProvider.checkPermission();
  }


  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction? p = await PlacesAutocomplete.show(
      context: context,
      apiKey: Credentials.API_KEY,
      onError: onError,
      mode: Mode.overlay,
      types: [],
      language: "en",
      decoration: InputDecoration(
        hintText: 'Search',
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: const BorderSide(
            color: Colors.white,
          ),
        ),
      ),
      components: [Component(Component.country, "us"), Component(Component.country, "in")],
      strictbounds: false,
    );
    // displayPrediction(p);
    addressProvider.displayPrediction(p, context);
  }

  void onError(PlacesAutocompleteResponse response) {

    ScaffoldMessenger.of(homeScaffoldKey.currentState?.context ?? context).showSnackBar(
      SnackBar(content: Text(response.errorMessage ?? "")),
    );
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
                Consumer<AddressProvider>(builder: (ctx, addressData, child) {
                  return SizedBox(
                    height: 0.50.sh,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        GoogleMap(
                          mapType: MapType.normal,
                          compassEnabled: true,
                          initialCameraPosition: addressData.myPosition,
                          onMapCreated: (GoogleMapController controller) {
                            addressProvider.controller.complete(controller);
                          },
                          onTap: addressData.selectLocation,
                          markers: {
                            Marker(markerId: MarkerId("m1"), position: addressData.lastMapPosition),
                          },
                          zoomGesturesEnabled: true,
                          zoomControlsEnabled: false,
                          gestureRecognizers: Set()
                            ..add(Factory<OneSequenceGestureRecognizer>(() => EagerGestureRecognizer()))
                            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
                            ..add(Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
                            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
                            ..add(Factory<VerticalDragGestureRecognizer>(() => VerticalDragGestureRecognizer())),
                        ),

                        //  Search Places in Google
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
                                    controller: addressData.searchController,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),

                        // Goto Current Location
                        Positioned(
                            right: 15,
                            bottom: 15,
                            child: IconButton(
                              icon: const Icon(
                                Icons.gps_fixed_rounded,
                                size: 40,
                              ),
                              onPressed: () {
                                addressData.gotoCurrentLocation();
                              },
                              color: AppColor.colorPrimary,
                            )),

                        // Center Location Pin Image
                        // const Align(
                        //     alignment: Alignment.center,
                        //     child: Icon(
                        //       IcoFontIcons.locationPin,
                        //       size: 40,
                        //       color: AppColor.colorPrimary,
                        //     ),
                        // ),
                      ],
                    ),
                  );
                }),
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
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Consumer<AddressProvider>(builder: (ctx, addressData, child) {
                                return CommonWidget.createTextField(
                                    labelText: "Location",
                                    maxLines: 2,
                                    controller: addressData.locationController
                                );
                              }),
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
                                          side: BorderSide(color: isHome ? AppColor.colorPrimary : AppColor.tab_unselected, width: 2),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                    icon: Icon(Icons.home_outlined, color: isHome ? AppColor.colorPrimary : AppColor.tab_unselected),
                                    label: Text("Home", style: UITextStyle.regularTextStyle(color: isHome ? AppColor.colorPrimary : AppColor.tab_unselected),),
                                  ),
                                  TextButton.icon(
                                    style: TextButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                          side: BorderSide(color: isWork ? AppColor.colorPrimary : AppColor.tab_unselected, width: 2),
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
                                    icon: Icon(Icons.work_outline_rounded, color: isWork ? AppColor.colorPrimary : AppColor.tab_unselected),
                                    label: Text("Work", style: UITextStyle.regularTextStyle(color: isWork ? AppColor.colorPrimary : AppColor.tab_unselected),),
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
                                          side: BorderSide(color: isOther ? AppColor.colorPrimary : AppColor.tab_unselected, width: 2),
                                          borderRadius: BorderRadius.circular(10)
                                      ),
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                                    ),
                                    icon: Icon(Icons.pin_drop_outlined, color: isOther ? AppColor.colorPrimary : AppColor.tab_unselected),
                                    label: Text("Other", style: UITextStyle.regularTextStyle(color: isOther ? AppColor.colorPrimary : AppColor.tab_unselected),),
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
