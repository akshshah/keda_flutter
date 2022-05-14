import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_image.dart';
import '../models/RentItem.dart';


class RentItemWidget extends StatelessWidget {
  const RentItemWidget({Key? key, required this.rentItem}) : super(key: key);

  final RentItem rentItem;


  TextStyle headingStyle(Color appColor, double size) {
    return TextStyle(
        fontWeight: FontWeight.w600, color: appColor, fontSize: size);
  }

  TextStyle categoryStyle(Color appColor,  double size){
    return TextStyle(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, color: appColor, fontSize: size);
  }
  

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0,vertical: 5),
      child: InkWell(
        onTap: () {},
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        ),
                    child: Image.asset(
                      rentItem.type == 1 ?  AppImage.watch : rentItem.type == 2 ? AppImage.headphone : AppImage.shoeImage ,
                      height: 130,
                      width: 130,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      height: 130,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(child: Text(rentItem.category, style: categoryStyle(AppColor.dark_sky_blue, 14),)),
                              Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: rentItem.status == "Return Accepted" ? AppColor.status_active : AppColor.status_debited,
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(3),
                                  ),
                                ),
                                padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                                child: Text(rentItem.status, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),),
                              ),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Text(rentItem.productName, style: headingStyle(AppColor.heading_text, 14),),
                          Text("Total : \$" + rentItem.price, style: headingStyle(AppColor.price_color, 14),),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              Container(
                decoration: const BoxDecoration(
                  color: AppColor.light_sky_blue_edit_text,
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10))
                ),
                padding: const EdgeInsets.all(5),
                child: IntrinsicHeight(
                  child: Row(
                    children: [
                      SizedBox(
                          child: Text(rentItem.deliveryType, textAlign: TextAlign.center, style: headingStyle(AppColor.heading_text, 12),),
                        width: 130,
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                        child: VerticalDivider(thickness: 1, width: 1,color: Colors.grey, ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Text("Pickup", style: categoryStyle(AppColor.heading_text, 11),),
                              const SizedBox(height: 2,),
                              Text(
                                rentItem.pickUpDate,
                                style: headingStyle(AppColor.heading_text, 12),
                              ),
                              const SizedBox(height: 2,),
                              Text(rentItem.pickUpTime, style: headingStyle(AppColor.heading_text_50, 12),),
                            ]
                        ),
                      ),
                      const SizedBox(width: 5,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text("Drop Off", style: categoryStyle(AppColor.heading_text, 11),),
                            const SizedBox(height: 2,),
                            Text(
                              rentItem.dropOffDate,
                              style: headingStyle(AppColor.heading_text, 12),
                            ),
                            const SizedBox(height: 2,),
                            Text(rentItem.dropOffTime, style: headingStyle(AppColor.heading_text_50, 12),),
                          ]
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
