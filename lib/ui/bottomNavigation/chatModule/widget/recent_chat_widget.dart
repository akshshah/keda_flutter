import 'package:flutter/material.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_image.dart';
import '../models/RecentChat.dart';


class RecentChatWidget extends StatelessWidget {
  const RecentChatWidget({Key? key, required this.recentChat}) : super(key: key);

  final RecentChat recentChat;

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
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.only(top: 10),
        child: Card(
          elevation: 5,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(recentChat.category, style: categoryStyle(),),
                const SizedBox(height: 10,),
                Text(recentChat.productName, style: headingStyle(),),
                const SizedBox(height: 10,),
                Text(recentChat.lastMessage, style: const TextStyle(color: AppColor.heading_text, fontWeight: FontWeight.w200),),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.fill,
                              image: AssetImage(recentChat.type == 1 ? AppImage.watch : recentChat.type == 2 ? AppImage.headphone : AppImage.shoeImage))),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      recentChat.username,
                      style: textStyle(),
                    ),
                    Expanded(
                        child: Text(
                      recentChat.time,
                      style: const TextStyle(
                          color: AppColor.heading_text_78,
                          fontWeight: FontWeight.w200,),
                          textAlign: TextAlign.end,
                    ))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
