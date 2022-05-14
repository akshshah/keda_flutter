import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/explore_module/screens/recent_search_tab.dart';
import 'package:keda_flutter/ui/bottomNavigation/explore_module/screens/deals_in_your_area_tab.dart';

import 'package:keda_flutter/utils/app_color.dart';


class ExploreTabsScreen extends StatelessWidget {
  const ExploreTabsScreen({Key? key}) : super(key: key);

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
                        child: Text("Deals In Your Area"),
                      ),
                    ),
                    Tab(
                      child: Align(
                        alignment: Alignment.center,
                        child: Text("Recent Search"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          body: const TabBarView(
            children: [
              AreaDealsTab(),
              RecentSearchTab()
            ],
          ),
        ),
    );
  }
}
