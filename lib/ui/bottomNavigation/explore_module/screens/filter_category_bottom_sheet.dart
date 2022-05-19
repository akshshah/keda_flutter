import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/ui_text_style.dart';

enum CategoryEnum {
  clothes,
  electronics,
  furniture,
  general,
  household,
  jewelry,
  lawncare,
  music,
  photo,
  sports,
  none
}

class FilterCategoryBottomSheet extends StatefulWidget {
  const FilterCategoryBottomSheet({Key? key, required this.scrollController})
      : super(key: key);

  final ScrollController scrollController;

  @override
  State<FilterCategoryBottomSheet> createState() =>
      _FilterCategoryBottomSheetState();
}

class _FilterCategoryBottomSheetState extends State<FilterCategoryBottomSheet> {
  CategoryEnum? _categoryRadio = CategoryEnum.none;
  var categorySelected = "";

  Widget getRadioWidget(String text, CategoryEnum categoryEnum) {
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
            value: categoryEnum,
            groupValue: _categoryRadio,
            onChanged: (CategoryEnum? value) {
              setState(() {
                _categoryRadio = value;
                categorySelected = text;
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

  List<Map<String, dynamic>> categoryMap = [
    {"name": "Clothes", "enum": CategoryEnum.clothes},
    {"name": "Electronics", "enum": CategoryEnum.electronics},
    {"name": "Furniture", "enum": CategoryEnum.furniture},
    {"name": "General", "enum": CategoryEnum.general},
    {"name": "Household", "enum": CategoryEnum.household},
    {"name": "Jewelry", "enum": CategoryEnum.jewelry},
    {"name": "Lawn Care", "enum": CategoryEnum.lawncare},
    {"name": "Music", "enum": CategoryEnum.music},
    {"name": "Photo/Video", "enum": CategoryEnum.photo},
    {"name": "Sports", "enum": CategoryEnum.sports},
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
                  "Select Category",
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
                    Navigator.pop(context, categorySelected);
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
          child: CustomScrollView(
            controller: widget.scrollController,
            slivers: [
              SliverFillRemaining(
                hasScrollBody: true,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 5),
                              decoration: BoxDecoration(
                                color: AppColor.light_sky_blue,
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.search,
                                    color: AppColor.heading_text,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Expanded(
                                    child: TextFormField(
                                      decoration: const InputDecoration(
                                        hintText: "Search category",
                                        border: InputBorder.none,
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    constraints: const BoxConstraints(),
                                    onPressed: () {},
                                    icon: const Icon(
                                      Icons.close,
                                      color: AppColor.heading_text,
                                    ),
                                    padding: EdgeInsets.zero,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemBuilder: (ctx, index) => getRadioWidget(
                              categoryMap[index]["name"],
                              categoryMap[index]["enum"]),
                          itemCount: categoryMap.length,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
