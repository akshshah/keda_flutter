import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:keda_flutter/providers/profile_screen_provider.dart';
import 'package:keda_flutter/ui/bottomNavigation/profileModule/screens/edit_profile_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/profileModule/screens/profile_tabs_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/profileModule/screens/settings_screen.dart';
import 'package:keda_flutter/utils/app_color.dart';
import 'package:keda_flutter/utils/app_image.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';
import 'package:keda_flutter/utils/utils.dart';
import 'package:provider/provider.dart';

import '../../../../utils/logger.dart';
import '../models/user_account_model.dart';
import '../models/user_rate_review_model.dart';


class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> getUserRateReview(BuildContext context) async {
    final response = await Provider.of<ProfileProvider>(context, listen: false).getUserRateReviewAPI();
    Logger().v("Response Code : === ${response?.status} ");
    if (response?.status == 200) {

    } else {
      Utils.showSnackBarWithContext(context, response?.message ?? "");
    }
  }

  Future<void> getUserAccountDetails(BuildContext context) async {
    final response = await Provider.of<ProfileProvider>(context, listen: false).getUserAccountDetails();
    Logger().v("Response Code : === ${response?.status} ");
    if (response?.status == 200) {

    } else {
      Utils.showSnackBarWithContext(context, response?.message ?? "");
    }
  }

  @override
  Widget build(BuildContext context) {

    Logger().v("Load Again");

    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          body: FutureBuilder(
            future: Future.wait([getUserRateReview(context), getUserAccountDetails(context)]),
            builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.colorPrimary,
              ),
            ) : Column(
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
                                Navigator.of(context).pushNamed(SettingsScreen.routeName);
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
                              Consumer<ProfileProvider>(builder: (ctx, profileData, child) {
                                return Container(
                                  height: 75,
                                  width: 75,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(200),
                                    child: FadeInImage(
                                      fit: BoxFit.cover,
                                      placeholder: AssetImage(AppImage.personImage),
                                      fadeInDuration: const Duration(milliseconds: 100),
                                      image: NetworkImage(profileData.userAccount?.profilePicture ?? ""),
                                      imageErrorBuilder: (ctx, error, stacktrace ) {
                                        return Image.asset(AppImage.personImage, height: 75, width: 75, fit: BoxFit.cover,);
                                      },
                                    ),
                                  ),
                                );
                              }),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Consumer<ProfileProvider>(builder: (ctx, profileData, child) {
                                          return Expanded(
                                            child: Text(
                                              profileData.userAccount?.userName ?? "",
                                              style: const TextStyle(
                                                fontWeight:
                                                FontWeight.w600,
                                                color:
                                                AppColor.heading_text,
                                                fontSize: 16,),
                                            ),
                                          );
                                        }),
                                        IconButton(
                                          constraints:
                                              const BoxConstraints(),
                                          padding:
                                              const EdgeInsets.all(3),
                                          onPressed: () {
                                            Navigator.of(context).pushNamed(EditProfileScreen.routeName).then((value) {
                                              if(value == true){
                                                setState((){

                                                });
                                              }

                                            });
                                          },
                                          iconSize: 20,
                                          icon: const Icon(
                                            Icons.edit,
                                            color: AppColor.dark_sky_blue,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    Consumer<ProfileProvider>(builder: (ctx, profileData, child) {
                                      return Row(
                                        children: [
                                          RatingBarIndicator(
                                            rating: profileData.userRateReview?.userAvgRating! != null ? double.parse(profileData.userRateReview?.userAvgRating! ?? "0") : 0.0,
                                            itemBuilder:
                                                (BuildContext context,
                                                int index) =>
                                            const Icon(
                                              Icons.star,
                                              color: AppColor.star_filled,
                                            ),
                                            unratedColor:
                                            AppColor.star_empty,
                                            itemCount: 5,
                                            itemSize: 25,
                                            direction: Axis.horizontal,
                                          ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Text(
                                            "(${profileData.userRateReview?.userTotalRatingandreview ?? 0})",
                                            style: UITextStyle.semiBoldTextStyle(color: AppColor.price_color),
                                          ),
                                        ],
                                      );
                                    }),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Consumer<ProfileProvider>(builder: (ctx, profileData, child) {
                                      return  Text(
                                        "${profileData.totalProducts} Products",
                                        style: UITextStyle.semiBoldTextStyle(color: AppColor.price_color),
                                      );
                                    }),
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
      ),
    );
  }
}
