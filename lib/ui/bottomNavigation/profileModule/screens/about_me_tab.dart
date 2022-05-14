import 'package:flutter/material.dart';
import 'package:keda_flutter/utils/app_color.dart';

class AboutMeTab extends StatelessWidget {
  const AboutMeTab({Key? key}) : super(key: key);

  TextStyle headingStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w600, color: AppColor.price_color);
  }

  TextStyle textStyle() {
    return const TextStyle(
        fontWeight: FontWeight.w200, color: AppColor.heading_text);
  }

  @override
  Widget build(BuildContext context) {

    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Container(
            padding: const EdgeInsets.fromLTRB(15, 15, 15, 10),
            child: Column(
              children: <Widget>[
                Expanded(child:  Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "About Me:",
                          style: headingStyle(),
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          "This is Android Developer",
                          style: textStyle(),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const Divider(
                          thickness: 2,
                          color: AppColor.light_sky_blue,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.email_outlined,
                              color: AppColor.price_color,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Email:",
                              style: headingStyle(),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          "aksh@gmail.com",
                          style: textStyle(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.phone_android_outlined,
                              color: AppColor.price_color,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(
                              "Phone Number:",
                              style: headingStyle(),
                            )
                          ],
                        ),
                        const SizedBox(
                          height: 7,
                        ),
                        Text(
                          "+91 9099987640",
                          style: textStyle(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ],
                ),),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    "assets/images/img_invite_friend.png",
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
