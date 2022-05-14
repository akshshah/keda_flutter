import 'package:flutter/material.dart';
import '../../../../utils/app_color.dart';
import '../models/RentItem.dart';
import '../widget/rent_item_widget.dart';


class RentedRentalsTab extends StatelessWidget {
  const RentedRentalsTab({Key? key}) : super(key: key);

  Future<void> _refreshProducts(BuildContext context) async{
    try {
    } catch (e) {

    }
  }

  final List<RentItem> _myList = const [
    RentItem(id: "1", status: "Return Accepted", productName: "New Product", category: "Clothes",
        pickUpTime: "11:00 am", dropOffTime: "12:00 pm", pickUpDate: "Feb 23, 2022",
        dropOffDate: "Feb 23, 2022", price: "2.00", deliveryType: "Pickup", type: 1),
    RentItem(id: "2", status: "Rejected", productName: "Bottle", category: "General",
        pickUpTime: "2:00 pm", dropOffTime: "3:00 pm", pickUpDate: "Apr 10, 2022",
        dropOffDate: "Apr 10, 2022", price: "5.00", deliveryType: "Delivered by Renter", type: 2)
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
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
