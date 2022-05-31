import 'package:flutter/material.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';

import '../../../../utils/app_color.dart';
import 'about_me_tab.dart';
import 'my_products_tab.dart';


class ProfileTabsScreen extends StatelessWidget {
  const ProfileTabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace:  PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: DecoratedBox(
              decoration: const BoxDecoration(
                border: Border(
                    bottom:
                    BorderSide(width: 2, color: AppColor.light_sky_blue)),
              ),
              child: TabBar(
                unselectedLabelColor: AppColor.tab_unselected,
                labelColor: AppColor.colorPrimary,
                indicator: const BoxDecoration(
                  border: Border(
                      bottom:
                      BorderSide(width: 2, color: AppColor.colorPrimary)),
                ),
                indicatorColor: AppColor.light_sky_blue,
                labelStyle: UITextStyle.semiBoldTextStyle(letterSpacing: 0.5, fontSize: 14),
                tabs: const [
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("About"),
                    ),
                  ),
                  Tab(
                    child: Align(
                      alignment: Alignment.center,
                      child: Text("Listed"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            AboutMeTab(),
            MyProductsTab()
          ],
        ),
      ),
    );
  }
}
