import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../explore_module/models/DealItem.dart';
import '../../explore_module/widget/deal_item_widget.dart';

class SavedScreen extends StatelessWidget {
  const SavedScreen({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async {
    try {} catch (e) {}
  }

  final List<DealItem> _myList = const [
    DealItem(
        id: "1", name: "Item 1", category: "Clothes", price: "15.00", type: 1),
    DealItem(
        id: "2", name: "Item 2", category: "General", price: "10.00", type: 2),
    DealItem(
        id: "3",
        name: "Item 3",
        category: "Furniture",
        price: "20.00",
        type: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            margin: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Saved",
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    color: AppColor.heading_text,
                    fontSize: 24,
                  ),
                ),
                const Divider(
                  thickness: 1,
                  color: AppColor.light_sky_blue,
                ),
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: RefreshIndicator(
                        child: GridView(
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                                  maxCrossAxisExtent: 200,
                                  crossAxisSpacing: 0,
                                  mainAxisSpacing: 0,
                                  childAspectRatio: 0.70),
                          children: _myList
                              .map((e) => DealItemWidget(dealItem: e))
                              .toList(),
                          shrinkWrap: true,
                        ),
                        onRefresh: () => _refreshProducts(context)),
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
