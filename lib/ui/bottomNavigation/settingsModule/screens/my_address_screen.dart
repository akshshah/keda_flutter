import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/settingsModule/screens/add_address_screen.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';

import '../../../../utils/app_color.dart';

class MyAddressScreen extends StatelessWidget {
  const MyAddressScreen({Key? key}) : super(key: key);

  static const routeName = "/my-address-screen";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorPrimary,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("My Address"),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Divider(
                height: 2,
                color: AppColor.dark_sky_blue,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  Navigator.of(context).pushNamed(AddAddressScreen.routeName);
                },
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  ListTile(
                    shape: const Border(
                      bottom:  BorderSide(width: 1, color: AppColor.heading_text_50),
                      top: BorderSide(width: 1, color: AppColor.heading_text_50),
                    ),
                    leading: const Icon(Icons.home_outlined, color: AppColor.heading_text,),
                    title: Text("Home", style: UITextStyle.semiBoldTextStyle(fontSize: 16),),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text("102, Dhanna Apt, Arihant Park, Sumul Dairy Road, Surat.", style: UITextStyle.regularTextStyle(),),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right, size: 30, color: AppColor.heading_text,),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    horizontalTitleGap: 5,

                  ),
                  const SizedBox(height: 10,),
                  ListTile(
                    shape: const Border(
                      bottom:  BorderSide(width: 1, color: AppColor.heading_text_50),
                      top: BorderSide(width: 1, color: AppColor.heading_text_50),
                    ),
                    leading: const Icon(Icons.pin_drop_outlined, color: AppColor.heading_text,),
                    title: Text("Other", style: UITextStyle.semiBoldTextStyle(fontSize: 16),),
                    subtitle: Padding(
                      padding: const EdgeInsets.only(top: 5),
                      child: Text("3574 Jenna Lane Des Moines, Near Lake View IA 50317", style: UITextStyle.regularTextStyle(),),
                    ),
                    trailing: const Icon(Icons.keyboard_arrow_right, size: 30, color: AppColor.heading_text,),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                    horizontalTitleGap: 5,

                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
