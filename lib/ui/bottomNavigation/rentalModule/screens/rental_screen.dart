import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/rentalModule/screens/rental_tabs_screen.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/ui_text_style.dart';


class RentalScreen extends StatelessWidget {
  const RentalScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Container(
              margin: const EdgeInsets.all(10),
              child: Column(
                children: [
                  Row(
                    children:  [
                      Expanded(
                        child: Text(
                          "Rentals",
                          style: UITextStyle.semiBoldTextStyle(fontSize: 24),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      TextButton.icon(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        onPressed: () {},
                        icon: const Icon(Icons.add, color: AppColor.heading_text, size: 15,),
                        label: const Text(
                          "Add Item", style: TextStyle( color: AppColor.heading_text, fontWeight: FontWeight.w600),
                        ),
                      ),
                    ],
                  ),
                  const Divider(thickness: 1, color: AppColor.light_sky_blue,),
                  const SizedBox(height: 12,),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 5),
                          decoration: BoxDecoration(
                            color: AppColor.light_sky_blue,
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.search, color: AppColor.heading_text,),
                              const SizedBox(width: 10,),
                              Expanded(
                                child: TextFormField(
                                  decoration: const InputDecoration(
                                    hintText: "Search your inbox",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12,),
                  const Divider(thickness: 1, color: AppColor.light_sky_blue,),
                  Expanded(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: const RentalsTabsScreen(),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
