import 'package:flutter/material.dart';

import '../models/DealItem.dart';
import '../widget/deal_item_widget.dart';


class AreaDealsTab extends StatelessWidget {
  const AreaDealsTab({Key? key}) : super(key: key);

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
    return RefreshIndicator(
        child: GridView(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              crossAxisSpacing: 0,
              mainAxisSpacing: 0,
              childAspectRatio: 0.70
          ),
          children: _myList.map((e) => DealItemWidget(dealItem: e)).toList(),
          shrinkWrap: true,
        ),
        onRefresh: () => _refreshProducts(context)
    );
  }
}
