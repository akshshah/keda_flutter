import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../models/RentItem.dart';
import '../widget/rent_item_widget.dart';

class ListingRentalsTab extends StatelessWidget {
  const ListingRentalsTab({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async{
    try {
    } catch (e) {

    }
  }

  final List<RentItem> _myList = const [
    RentItem(id: "2", status: "Return Rejected", productName: "Camera", category: "Electronics",
        pickUpTime: "2:00 pm", dropOffTime: "3:00 pm", pickUpDate: "Mar 10, 2022",
        dropOffDate: "Mar 10, 2022", price: "10.00", deliveryType: "Pickup", type: 2),
    RentItem(id: "1", status: "Return Accepted", productName: "New Product", category: "Furniture",
        pickUpTime: "9:00 am", dropOffTime: "12:00 pm", pickUpDate: "Jan 23, 2022",
        dropOffDate: "Jan 23, 2022", price: "2.00", deliveryType: "Pickup", type: 3),
    RentItem(id: "1", status: "Return Accepted", productName: "New Product", category: "Clothes",
        pickUpTime: "11:00 am", dropOffTime: "12:00 pm", pickUpDate: "Feb 23, 2022",
        dropOffDate: "Feb 23, 2022", price: "2.00", deliveryType: "Pickup", type: 1),

  ];

  @override
  Widget build(BuildContext context) {
    return  Container(
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
                    "All", style: TextStyle( color: AppColor.heading_text, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
          const SizedBox(height: 5,),
          Expanded(
            child: RefreshIndicator(
                onRefresh: () => _refreshProducts(context),
                child: ListView.builder(
                  itemBuilder: (ctx, index) {
                    return RentItemWidget(rentItem: _myList[index]);
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
