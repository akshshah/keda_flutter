import 'package:flutter/material.dart';
import 'package:keda_flutter/utils/app_color.dart';

import '../models/DealItem.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({Key? key, required this.dealItem}) : super(key: key);

  final DealItem dealItem;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        print("Card Tapped");
      },
      child: Card(
        elevation: 5,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              child: Image.asset(dealItem.type == 1 ? 'assets/images/watch.jpg' : dealItem.type == 2 ? 'assets/images/headphone.jpg' : 'assets/images/space_hippie.jpg' , height: 150, width: double.infinity, fit: BoxFit.cover,),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          dealItem.category,
                          style: const TextStyle(
                              color: AppColor.dark_sky_blue,
                              overflow: TextOverflow.ellipsis,
                          fontWeight: FontWeight.w600,
                          fontStyle: FontStyle.italic),
                        ),
                      ),
                      IconButton(
                        constraints: const BoxConstraints(),
                        onPressed: () {
                          print("Saved");
                        },
                        icon: const Icon(Icons.bookmark_border, color: AppColor.dark_sky_blue,),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5,),
                  Text(
                    dealItem.name,
                    maxLines: 2,
                    style: const TextStyle(
                        color: AppColor.heading_text,
                      fontWeight: FontWeight.w600,),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 5,),
                  Text("\$ ${dealItem.price}/hr",
                    maxLines: 2,
                    style: const TextStyle(
                      color: AppColor.price_color,
                      fontWeight: FontWeight.w600,),
                    textAlign: TextAlign.left,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
