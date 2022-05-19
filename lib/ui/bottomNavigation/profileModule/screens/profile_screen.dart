import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keda_flutter/ui/bottomNavigation/profileModule/screens/profile_tabs_screen.dart';
import 'package:keda_flutter/utils/app_color.dart';
import 'package:keda_flutter/utils/app_image.dart';


class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: Column(
            children: [
              SizedBox(
                // height: MediaQuery.of(context).size.height * 0.3,
                height: 190,
                child: Stack(
                  children: [
                    Container(
                      // height:  MediaQuery.of(context).size.height * 0.12 ,
                      height:  120,
                      decoration: BoxDecoration(
                          boxShadow: kElevationToShadow[4],
                          color: AppColor.colorPrimary,
                          borderRadius: const BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20))),
                      padding: const EdgeInsets.fromLTRB(10, 15, 10, 0),
                      child:  Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Expanded(
                            child: Text(
                              "Profile",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                                fontSize: 24,
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              print("pressed");
                            },
                            child: const Icon(Icons.settings, color: Colors.white,),
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      // top: MediaQuery.of(context).size.height * 0.08,
                      top: 65,
                      child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        padding: const EdgeInsets.all(10),
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          boxShadow: kElevationToShadow[2],
                          borderRadius: const BorderRadius.all(
                            Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              maxRadius: 35,
                              backgroundImage:
                                  AssetImage(AppImage.watch),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      const Expanded(
                                        child: Text("Aksh Shah", style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.heading_text, fontSize: 16),),
                                      ),
                                      IconButton(
                                        constraints: const BoxConstraints(),
                                        padding: const EdgeInsets.all(3),
                                        onPressed: () {
                                          print("pressed");
                                        },
                                        iconSize: 20,
                                        icon: const Icon(
                                          Icons.edit,
                                          color: AppColor.dark_sky_blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 5,),
                                  Row(
                                    children: [
                                     RatingBarIndicator(
                                      rating: 2.5,
                                       itemBuilder: (BuildContext context, int index) => const Icon(
                                         Icons.star,
                                         color: AppColor.star_filled,
                                       ),
                                       unratedColor: AppColor.star_empty,
                                       itemCount: 5,
                                       itemSize: 25,
                                       direction: Axis.horizontal,
                                     ),
                                      const SizedBox(width: 10,),
                                      const Text("(2)", style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.price_color),),
                                    ],
                                  ),
                                  const SizedBox(height: 10,),
                                  const Text("15 Products", style: TextStyle(fontWeight: FontWeight.w600, color: AppColor.price_color,), )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(thickness: 1, color: AppColor.light_sky_blue,),
              Expanded(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: const ProfileTabsScreen(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
