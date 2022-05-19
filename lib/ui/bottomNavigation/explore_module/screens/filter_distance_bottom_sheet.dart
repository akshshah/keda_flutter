import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/ui_text_style.dart';

enum DistanceEnum { miles0 ,miles10, miles20, miles30, miles40, miles50, miles60, miles70, miles80, miles90, miles100 ,none}

class FilterDistanceBottomSheet extends StatefulWidget {
  const FilterDistanceBottomSheet({Key? key, required this.distanceType, required this.scrollController}) : super(key: key);

  final String distanceType;
  final ScrollController scrollController;


  @override
  State<FilterDistanceBottomSheet> createState() => _FilterDistanceBottomSheetState();
}

class _FilterDistanceBottomSheetState extends State<FilterDistanceBottomSheet> {

  DistanceEnum? _distanceRadio = DistanceEnum.none;

  Widget getRadioWidget(String text, DistanceEnum distanceEnum) {
    return SizedBox(
      height: 40,
      child: ListTile(
        title: Text(
          text,
          style: UITextStyle.semiBoldTextStyle(
              fontSize: 16, color: AppColor.colorPrimary),
        ),
        trailing: Transform.scale(
          scale: 1.1,
          child: Radio(
            value: distanceEnum,
            groupValue: _distanceRadio,
            onChanged: (DistanceEnum? value) {
              setState(() {
                _distanceRadio = value;
              });
            },
            activeColor: AppColor.colorPrimary,
            fillColor: MaterialStateColor.resolveWith(
                    (states) => AppColor.colorPrimary),
          ),
        ),
        contentPadding: const EdgeInsets.only(left: 10),
      ),
    );
  }


  List<Map<String, dynamic>> distanceMap = [
    {"name": "0 Miles", "enum" : DistanceEnum.miles0 },
    {"name": "10 Miles", "enum" : DistanceEnum.miles10},
    {"name": "20 Miles", "enum" : DistanceEnum.miles20},
    {"name": "30 Miles", "enum" : DistanceEnum.miles30},
    {"name": "40 Miles", "enum" : DistanceEnum.miles40},
    {"name": "50 Miles", "enum" :DistanceEnum.miles50},
    {"name": "60 Miles", "enum" : DistanceEnum.miles60},
    {"name": "70 Miles", "enum" : DistanceEnum.miles70},
    {"name": "80 Miles", "enum" : DistanceEnum.miles80},
    {"name": "90 Miles", "enum" : DistanceEnum.miles90},
    {"name": "100 Miles", "enum" : DistanceEnum.miles100},
  ];

  @override
  Widget build(BuildContext context) {
    return  Column(
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
                  "Select ${widget.distanceType} Distance",
                  style: UITextStyle.semiBoldTextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Done",
                      style: UITextStyle.semiBoldTextStyle(fontSize: 16),
                      recognizer: TapGestureRecognizer()..onTap = () {},
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx, index) => getRadioWidget(
                        distanceMap[index]["name"],
                        distanceMap[index]["enum"]),
                    itemCount: distanceMap.length,
                    controller: widget.scrollController,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
