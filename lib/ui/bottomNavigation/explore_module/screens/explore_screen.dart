import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/explore_module/screens/filter_bottom_sheet.dart';
import 'package:keda_flutter/utils/app_color.dart';
import 'package:keda_flutter/utils/utils.dart';

import '../../../../utils/ui_text_style.dart';
import 'explore_tabs_screen.dart';

class ExploreScreen extends StatelessWidget {
  const ExploreScreen({Key? key}) : super(key: key);

  void _showFilterBottomSheet(BuildContext ctx){
    // showModalBottomSheet<dynamic>(
    //     isScrollControlled: true,
    //     isDismissible: true,
    //     context: ctx,
    //     enableDrag: true,
    //     shape: const RoundedRectangleBorder(
    //       borderRadius: BorderRadius.only(
    //         topLeft: Radius.circular(16.0),
    //         topRight: Radius.circular(16.0),
    //       ),
    //     ),
    //     builder: (BuildContext bc) {
    //       return DraggableScrollableSheet(
    //           initialChildSize: 0.6,
    //           maxChildSize: 1 - (AppBar().preferredSize.height / MediaQuery.of(ctx).size.height),
    //           minChildSize: 0.4,
    //           expand: false,
    //           snap: true,
    //           snapSizes: const [0.4,],
    //           builder: (_,controller) {
    //         return FilterBottomSheet(scrollController: controller,);
    //       });
    //     }
    // );
    Utils.customBottomSheet(context: ctx, sheetName:  "FilterBottomSheet");
  }

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
                    children: [
                      Expanded(
                        child: Text(
                          "Explore",
                          style: UITextStyle.semiBoldTextStyle(fontSize: 24),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          print("pressed");
                        },
                        child: const Icon(Icons.notifications_none_rounded,),
                      )
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
                                    hintText: "Search for latest deals",
                                    border: InputBorder.none,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(width: 10,),
                      Ink(
                        decoration: ShapeDecoration(
                            color: AppColor.light_sky_blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)
                            ),
                            ),
                        child: IconButton(
                          onPressed: () {
                            _showFilterBottomSheet(context);
                          },
                          icon: const Icon(
                            Icons.tune,
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
                        child: const ExploreTabsScreen(),
                    ),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
