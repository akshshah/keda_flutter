import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/explore_module/screens/recent_search_tab.dart';
import 'package:keda_flutter/ui/bottomNavigation/explore_module/screens/deals_in_your_area_tab.dart';

import 'package:keda_flutter/utils/app_color.dart';

import '../../../../utils/ui_text_style.dart';


class ExploreTabsScreen extends StatelessWidget {
  const ExploreTabsScreen({Key? key}) : super(key: key);

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
          body: TabBarView(
            children: [
              AreaDealsTab(),
              RecentSearchTab()
            ],
          ),
        ),
    );
  }
}
