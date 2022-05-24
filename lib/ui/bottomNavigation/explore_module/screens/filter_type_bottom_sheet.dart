import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/ui_text_style.dart';

enum TypeEnum { highToLow, lowToHigh, newest, oldest, rating , none}


class FilterTypeBottomSheet extends StatefulWidget {
  const FilterTypeBottomSheet({Key? key, required this.scrollController}) : super(key: key);

  final ScrollController scrollController;

  @override
  State<FilterTypeBottomSheet> createState() => _FilterTypeBottomSheetState();
}

class _FilterTypeBottomSheetState extends State<FilterTypeBottomSheet> {

  TypeEnum? _typeRadio = TypeEnum.none;
  var typeSelected = "";

  Widget getRadioWidget(String text, TypeEnum distanceEnum) {
    return SizedBox(
      width: double.infinity,
      height: 40,
      child: RadioListTile<TypeEnum>(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(text, style: UITextStyle.semiBoldTextStyle(fontSize: 16, color: AppColor.colorPrimary,),),
        ),
        value: distanceEnum,
        groupValue: _typeRadio,
        onChanged: (TypeEnum? value) {
          setState(() {
            _typeRadio = value;
            typeSelected = text;
          });
        },
        activeColor: AppColor.colorPrimary,
        controlAffinity: ListTileControlAffinity.trailing,
      ),
    );
  }

  List<Map<String, dynamic>> typeMap = [
    {"name": "Price: High to Low", "enum" : TypeEnum.highToLow },
    {"name": "Price: Low to High", "enum" : TypeEnum.lowToHigh},
    {"name": "Newest", "enum" : TypeEnum.newest},
    {"name": "Oldest", "enum" : TypeEnum.oldest},
    {"name": "Rating", "enum" : TypeEnum.rating},
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
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
                  "Select Type",
                  style: UITextStyle.semiBoldTextStyle(fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: "Done",
                      style: UITextStyle.semiBoldTextStyle(fontSize: 16),
                      recognizer: TapGestureRecognizer()..onTap = () {
                        Navigator.pop(context, typeSelected );
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
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 10),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.zero,
                    itemBuilder: (ctx, index) => getRadioWidget(
                        typeMap[index]["name"],
                        typeMap[index]["enum"]),
                    itemCount: typeMap.length,
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
