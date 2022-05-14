import 'package:flutter/material.dart';


import '../../../../utils/app_color.dart';
import '../../../../utils/app_image.dart';
import '../../explore_module/models/DealItem.dart';

class MyItemWidget extends StatelessWidget {
  const MyItemWidget({Key? key, required this.dealItem}) : super(key: key);

  final DealItem dealItem;

  TextStyle headingStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w600, color: AppColor.heading_text);
  }

  TextStyle textStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w600, color: AppColor.price_color);
  }

  TextStyle categoryStyle(){
    return const TextStyle(fontWeight: FontWeight.w600, fontStyle: FontStyle.italic, color: AppColor.dark_sky_blue);
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
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10)),
                child: Image.asset(
                  dealItem.type == 1 ?  AppImage.watch : dealItem.type == 2 ? AppImage.headphone : AppImage.shoeImage ,
                  height: 130,
                  width: 130,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(dealItem.category, style: categoryStyle()),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(dealItem.name, style: headingStyle(),),
                  const SizedBox(
                    height: 10,
                  ),
                  Text("\$ ${dealItem.price}/hr", style: textStyle(),),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      Text("Project Status :", style: headingStyle(),),
                      const SizedBox(
                        width: 10,
                      ),
                      Container(
                          decoration: const BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: AppColor.status_active,
                            borderRadius: BorderRadius.all(
                              Radius.circular(3),
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                          child: const Text("Active", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 12),),
                      ),
                    ],
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
