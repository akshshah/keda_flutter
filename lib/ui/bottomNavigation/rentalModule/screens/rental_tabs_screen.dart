import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/rentalModule/screens/rented_rentals_tab.dart';
import 'package:keda_flutter/ui/bottomNavigation/rentalModule/screens/listing_rentals_tab.dart';

import '../../../../utils/app_color.dart';


class RentalsTabsScreen extends StatelessWidget {
  const RentalsTabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(length: 2,
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
          children: [
            RentedRentalsTab(),
            ListingRentalsTab()
          ],
        ),
      ),
    );

  }
}
