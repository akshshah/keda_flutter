import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/chatModule/screens/renting_inbox_tab.dart';
import 'package:keda_flutter/ui/bottomNavigation/chatModule/screens/listing_inbox_tab.dart';

import '../../../../utils/app_color.dart';

class InboxTabsScreen extends StatelessWidget {
  const InboxTabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: const PreferredSize(
            preferredSize: Size.fromHeight(50),
            child: DecoratedBox(
              decoration: BoxDecoration(
                border: Border(
                    bottom:
                    BorderSide(width: 2, color: AppColor.light_sky_blue)),
              ),
              child: TabBar(
                unselectedLabelColor: AppColor.tab_unselected,
                labelColor: AppColor.colorPrimary,
                indicator: BoxDecoration(
                  border: Border(
                      bottom:
                      BorderSide(width: 2, color: AppColor.colorPrimary)),
                ),
                indicatorColor: AppColor.light_sky_blue,
                labelStyle: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontFamily: "Raleway",
                    letterSpacing: 0.4,
                    fontSize: 14),
                tabs: [
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