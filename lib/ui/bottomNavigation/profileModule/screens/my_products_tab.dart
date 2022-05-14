import 'package:flutter/material.dart';
import 'package:keda_flutter/utils/app_color.dart';

import '../../explore_module/models/DealItem.dart';
import '../widget/my_item_widget.dart';

class MyProductsTab extends StatelessWidget {
  const MyProductsTab({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async{
    try {
    } catch (e) {

    }
  }

  final List<DealItem> _myList = const [
    DealItem(id: "1", name: "Item 1", category: "Clothes", price: "15.00",type: 1),
    DealItem(id: "2", name: "Item 2", category: "General", price: "10.00",type: 2),
    DealItem(id: "3", name: "Item 3", category: "Furniture", price: "20.00",type: 3),
    DealItem(id: "4", name: "Item 4", category: "Food", price: "5.00",type: 1),
    DealItem(id: "5", name: "Item 5", category: "Furniture", price: "20.00",type: 1),
    DealItem(id: "6", name: "Item 6", category: "Food", price: "5.00",type: 3),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.fromLTRB(15, 0, 15, 10),
        child: Column(
          children: [
            Row(
              children: [
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.keyboard_arrow_down, color: AppColor.heading_text,),
                    label: const Text(
                      "All Products", style: TextStyle( color: AppColor.heading_text, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    onPressed: () {},
                    icon: const Icon(Icons.add, color: AppColor.heading_text, size: 15,),
                    label: const Text(
                      "Add Item", style: TextStyle( color: AppColor.heading_text, fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 5,),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: ListView.builder(
                    itemBuilder: (ctx, index) {
                    return MyItemWidget(dealItem: _myList[index]);
                  },
                  itemCount: _myList.length,
                )
              ),
            ),
          ],
        ),
    );
  }
}
