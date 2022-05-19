import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/chatModule/screens/renting_inbox_tab.dart';
import 'package:keda_flutter/ui/bottomNavigation/chatModule/screens/listing_inbox_tab.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/ui_text_style.dart';

class InboxTabsScreen extends StatelessWidget {
  const InboxTabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: PreferredSize(
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
                      child: Text("Renting"),
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
        body: const TabBarView(
          children: [RentingInboxTab(), ListingInboxTab()],
        ),
      ),
    );
  }
}
