import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keda_flutter/utils/app_color.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';

import '../../../../utils/logger.dart';
import '../../../../utils/utils.dart';


enum RatingEnum { stars5 , stars4, stars3, stars2 , stars1 , none}


class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  RangeValues _currentRangeValues = const RangeValues(0, 80);
  var deliveryType = "";
  bool isEither = false;
  bool isPickup = false;
  bool isDelivered = false;
  var categorySelected =  "Choose Category";
  var minDistanceSelected =  "0 Miles";
  var maxDistanceSelected =  "10 Miles";
  var typeSelected =  "Select Type";

  RatingEnum? _ratingRadio = RatingEnum.none;

  Widget ratingWidget(String text, double rating){
    return Expanded(
      child: Row(
        children: [
          RatingBarIndicator(
            rating: rating,
            itemBuilder: (BuildContext context, int index) =>
            const Icon(
              Icons.star,
              color: AppColor.star_filled,
            ),
            unratedColor: AppColor.star_empty,
            itemCount: 5,
            itemSize: 20,
            direction: Axis.horizontal,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(
              text,
              style: UITextStyle.semiBoldTextStyle(
                  color: AppColor.dividerColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BoxDecoration customBoxDecoration() {
    return BoxDecoration(
      borderRadius:
      const BorderRadius.all(Radius.circular(5)),
      border: Border.all(
        width: 1,
        color: AppColor.heading_text,
        style: BorderStyle.solid,
      ),
    );
  }

  Widget dividerWidget(){
    return Column(
      children: const [
        SizedBox(
          height: 10,
        ),
        Divider(
          thickness: 1,
          color: AppColor.heading_text_08,
        ),
        SizedBox(
          height: 8,
        ),
      ],
    );
  }

  void _showCategoryBottomSheet(BuildContext ctx){
    Utils.customBottomSheet(context: ctx, sheetName:  "CategoryBottomSheet").then((value) {
      Logger().v("Result Category Filter :: $value");
      setState((){
        if(value != null && value != ""){
          categorySelected = value;
        }
      });
    });
  }

  void _showMinDistanceBottomSheet(BuildContext ctx){
    Utils.customBottomSheet(context: ctx, sheetName:  "MinDistanceBottomSheet").then((value) {
      Logger().v("Result Min Filter :: $value");
      setState((){
        if(value != null && value != ""){
          minDistanceSelected = value;
        }
      });
    });
  }

  void _showMaxDistanceBottomSheet(BuildContext ctx){
    Utils.customBottomSheet(context: ctx, sheetName:  "MaxDistanceBottomSheet").then((value) {
      Logger().v("Result Max Filter :: $value");
      setState((){
        if(value != null && value != ""){
          maxDistanceSelected = value;
        }
      });
    });
  }

  void _showTypeBottomSheet(BuildContext ctx){
    Utils.customBottomSheet(context: ctx, sheetName:  "TypeBottomSheet").then((value) {
      Logger().v("Result Type Filter :: $value");
      setState((){
        if(value != null && value != ""){
          typeSelected = value;
        }
      });
    });
  }

  void _resetFilter(){
    setState((){
      categorySelected =  "Choose Category";
      minDistanceSelected =  "0 Miles";
      maxDistanceSelected =  "10 Miles";
      typeSelected =  "Select Type";
      _ratingRadio = RatingEnum.none;
      _currentRangeValues = const RangeValues(0, 80);
      isEither = false;
      isPickup = false;
      isDelivered = false;
      deliveryType = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(15, 16, 15, 5),
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
                  "Filter",
                  style: UITextStyle.semiBoldTextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "Reset",
                  style: UITextStyle.semiBoldTextStyle(fontSize: 16),
                  recognizer: TapGestureRecognizer()..onTap = () {
                    _resetFilter();
                  },
                )
              ]))
            ],
          ),
        ),
        const Divider(
          thickness: 1,
          color: AppColor.heading_text_08,
        ),
        Expanded(
          child: SingleChildScrollView(
            controller: widget.scrollController,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Category:",
                        style: UITextStyle.semiBoldTextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          _showCategoryBottomSheet(context);
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  categorySelected,
                                  style: UITextStyle.semiBoldTextStyle(
                                      color: AppColor.colorPrimary, fontSize: 16),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColor.colorPrimary,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        thickness: 1,
                        color: AppColor.heading_text_08,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                "Distance:",
                                style: UITextStyle.semiBoldTextStyle(fontSize: 16),
                              )),
                          Text(
                            "0-10 miles",
                            style: UITextStyle.semiBoldTextStyle(
                                fontSize: 16, color: AppColor.heading_text_50),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Min", style: UITextStyle.regularTextStyle()),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    _showMinDistanceBottomSheet(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    decoration: customBoxDecoration(),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            minDistanceSelected,
                                            style: UITextStyle.semiBoldTextStyle(
                                                color: AppColor.colorPrimary,
                                                fontSize: 16),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColor.colorPrimary,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Max",
                                  style: UITextStyle.regularTextStyle(),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {
                                    _showMaxDistanceBottomSheet(context);
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    decoration: customBoxDecoration(),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            maxDistanceSelected,
                                            style: UITextStyle.semiBoldTextStyle(
                                                color: AppColor.colorPrimary,
                                                fontSize: 16),
                                          ),
                                        ),
                                        const Icon(
                                          Icons.keyboard_arrow_down,
                                          color: AppColor.colorPrimary,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        thickness: 1,
                        color: AppColor.heading_text_08,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: Text(
                                "Price Range:",
                                style: UITextStyle.semiBoldTextStyle(fontSize: 16),
                              )),
                          Expanded(
                            child: Text(
                              "\$${_currentRangeValues.start.round().toString()} - \$${_currentRangeValues.end.round().toString()}",
                              style: UITextStyle.semiBoldTextStyle(
                                  fontSize: 16, color: AppColor.heading_text_50),
                            ),
                          ),
                          Expanded(
                            child: InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 0, vertical: 5),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        "All",
                                        style: UITextStyle.semiBoldTextStyle(
                                            color: AppColor.colorPrimary,
                                            fontSize: 16),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.keyboard_arrow_down,
                                      color: AppColor.colorPrimary,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      RangeSlider(
                        values: _currentRangeValues,
                        min: 0,
                        max: 200,
                        divisions: 20,
                        labels: RangeLabels(
                          _currentRangeValues.start.round().toString(),
                          _currentRangeValues.end.round().toString(),
                        ),
                        onChanged: (RangeValues values) {
                          setState(() {
                            _currentRangeValues = values;
                          });
                        },
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Min", style: UITextStyle.regularTextStyle()),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    decoration: customBoxDecoration(),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "\$ ${_currentRangeValues.start.round().toString()}",
                                          style: UITextStyle.semiBoldTextStyle(
                                              color: AppColor.colorPrimary,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Max",
                                  style: UITextStyle.regularTextStyle(),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                InkWell(
                                  onTap: () {},
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 7, vertical: 5),
                                    decoration: customBoxDecoration(),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "\$ ${_currentRangeValues.end.round().toString()}",
                                          style: UITextStyle.semiBoldTextStyle(
                                              color: AppColor.colorPrimary,
                                              fontSize: 16),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      dividerWidget(),
                      Text(
                        "Shipping Method:",
                        style: UITextStyle.semiBoldTextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: TextButton(
                              child: Text(
                                "Either",
                                style: UITextStyle.semiBoldTextStyle(
                                    color: deliveryType == "either"
                                        ? AppColor.whiteColor
                                        : AppColor.heading_text_68, letterSpacing: 0.5),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (deliveryType == "either") {
                                    deliveryType = "";
                                  } else {
                                    deliveryType = "either";
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: deliveryType == "either"
                                    ? AppColor.colorPrimary
                                    : AppColor.heading_text_08,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text(
                                "Pickup",
                                style: UITextStyle.semiBoldTextStyle(
                                    color: deliveryType == "pickup"
                                        ? AppColor.whiteColor
                                        : AppColor.heading_text_68, letterSpacing: 0.5),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (deliveryType == "pickup") {
                                    deliveryType = "";
                                  } else {
                                    deliveryType = "pickup";
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: deliveryType == "pickup"
                                    ? AppColor.colorPrimary
                                    : AppColor.heading_text_08,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Expanded(
                            child: TextButton(
                              child: Text(
                                "Delivered",
                                style: UITextStyle.semiBoldTextStyle(
                                    color: deliveryType == "delivered"
                                        ? AppColor.whiteColor
                                        : AppColor.heading_text_68, letterSpacing: 0.5),
                              ),
                              onPressed: () {
                                setState(() {
                                  if (deliveryType == "delivered") {
                                    deliveryType = "";
                                  } else {
                                    deliveryType = "delivered";
                                  }
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: deliveryType == "delivered"
                                    ? AppColor.colorPrimary
                                    : AppColor.heading_text_08,
                              ),
                            ),
                          ),
                        ],
                      ),
                      dividerWidget(),
                      Text(
                        "Renter Rating:",
                        style: UITextStyle.semiBoldTextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ratingWidget("5 stars", 5),
                            Transform.scale(
                              scale: 1.1,
                              child: Radio(
                                value: RatingEnum.stars5,
                                groupValue: _ratingRadio,
                                onChanged: (RatingEnum? value) {
                                  setState(() {
                                    _ratingRadio = value;
                                  });
                                },
                                activeColor: AppColor.colorPrimary,
                                fillColor: MaterialStateColor.resolveWith((states) => AppColor.colorPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            ratingWidget("4 stars and up", 4),
                            Transform.scale(
                              scale: 1.1,
                              child: Radio(
                                value: RatingEnum.stars4,
                                groupValue: _ratingRadio,
                                onChanged: (RatingEnum? value) {
                                  setState(() {
                                    _ratingRadio = value;
                                  });
                                },
                                activeColor: AppColor.colorPrimary,
                                fillColor: MaterialStateColor.resolveWith((states) => AppColor.colorPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            ratingWidget("3 stars and up", 3),
                            Transform.scale(
                              scale: 1.1,
                              child: Radio(
                                value: RatingEnum.stars3,
                                groupValue: _ratingRadio,
                                onChanged: (RatingEnum? value) {
                                  setState(() {
                                    _ratingRadio = value;
                                  });
                                },
                                activeColor: AppColor.colorPrimary,
                                fillColor: MaterialStateColor.resolveWith((states) => AppColor.colorPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            ratingWidget("2 stars and up", 2),
                            Transform.scale(
                              scale: 1.1,
                              child: Radio(
                                value: RatingEnum.stars2,
                                groupValue: _ratingRadio,
                                onChanged: (RatingEnum? value) {
                                  setState(() {
                                    _ratingRadio = value;
                                  });
                                },
                                activeColor: AppColor.colorPrimary,
                                fillColor: MaterialStateColor.resolveWith((states) => AppColor.colorPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 30,
                        child: Row(
                          children: [
                            ratingWidget("1 star and up", 1),
                            Transform.scale(
                              scale: 1.1,
                              child: Radio(
                                value: RatingEnum.stars1,
                                groupValue: _ratingRadio,
                                onChanged: (RatingEnum? value) {
                                  setState(() {
                                    _ratingRadio = value;
                                  });
                                },
                                activeColor: AppColor.colorPrimary,
                                fillColor: MaterialStateColor.resolveWith((states) => AppColor.colorPrimary),
                              ),
                            ),
                          ],
                        ),
                      ),
                      dividerWidget(),
                      Text(
                        "Sort By:",
                        style: UITextStyle.semiBoldTextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      InkWell(
                        onTap: () {
                          _showTypeBottomSheet(context);
                        },
                        child: Padding(
                          padding:
                          const EdgeInsets.symmetric(horizontal: 0, vertical: 5),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  typeSelected,
                                  style: UITextStyle.semiBoldTextStyle(
                                      color: AppColor.colorPrimary, fontSize: 16),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down,
                                color: AppColor.colorPrimary,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child: Text(
                        "APPLY",
                        style: UITextStyle.boldTextStyle(
                            fontSize: 16,
                            color: AppColor.whiteColor,
                            letterSpacing: 1),
                      ),
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12)
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
