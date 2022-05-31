import 'package:flutter/material.dart';
import 'package:keda_flutter/utils/app_color.dart';

import '../../../../utils/logger.dart';
import '../../../../utils/utils.dart';
import '../../../authentication/models/login_data_model.dart';

class AboutMeTab extends StatelessWidget {
  AboutMeTab({Key? key}) : super(key: key);

  LoginData? userData;

  Future<void> getUserDetails(BuildContext context) async{
    try {
      userData = await LoginData.getUserDetails() ;
    } catch (e) {
      Logger().e(e.toString());
      Utils.showSnackBarWithContext(context, "Something went wrong");
    }
  }

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

    return FutureBuilder(
      future: getUserDetails(context),
      builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? const Center(
        child: CircularProgressIndicator(
          color: AppColor.colorPrimary,
        ),
      ) : CustomScrollView(
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
                            userData?.aboutUs?? "No information available",
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
                            userData?.email ?? "",
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
                            userData?.mobile ?? "",
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
      ),
    );
  }
}
