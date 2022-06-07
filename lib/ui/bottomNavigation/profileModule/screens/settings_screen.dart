import 'package:flutter/material.dart';
import 'package:icofont_flutter/icofont_flutter.dart';
import 'package:keda_flutter/providers/settings_screen_provider.dart';
import 'package:keda_flutter/ui/authentication/login_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/settingsModule/screens/my_address_screen.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';
import 'package:provider/provider.dart';

import '../../../../localization/localization.dart';
import '../../../../utils/app_color.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/navigation/navigation_service.dart';
import '../../../../utils/utils.dart';
import '../../../authentication/models/login_data_model.dart';


class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  static const routeName = "/settings-screen";

  _showAlertDialog(BuildContext context){
    showDialog(context: context, builder: (ctx) => AlertDialog(
      title: Text("Logout",  style: UITextStyle.boldTextStyle(fontSize: 20),),
      content:
      const Text("Are you sure you want to logout?",),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text("No", style: UITextStyle.semiBoldTextStyle(fontSize: 16, color:  AppColor.colorPrimary),),),
        TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              callLogoutAPI(context);
            },
            child: Text("Yes",style: UITextStyle.semiBoldTextStyle(fontSize: 16, color:  AppColor.colorPrimary),),),
      ],
    ));
  }

  Widget dividerWidget() {
    return Column(
      children: const [
        Divider(
          height: 2,
          color: AppColor.heading_text_50,
        ),
        SizedBox(
          height: 10,
        ),
        Divider(
          height: 2,
          color: AppColor.heading_text_50,
        ),
      ],
    );
  }

  callLogoutAPI(BuildContext context) async {
    Utils.showProgressDialog(context);

    Provider.of<SettingsProvider>(context, listen: false).logoutAPI().then((response) async {
      await Utils.dismissProgressDialog(context);
      Logger().e("Response Code : === ${response?.status} " );
      if (response?.status == 200) {
        await LoginData.currentUser.resetUserDetail();
        Utils.showSnackBarWithContext(context, response?.message?? "");
        NavigationService().navigateRemoveAndUntilNamed(LoginScreen.routeName);
      }
      else {
        Utils.showSnackBarWithContext(context, response?.message?? "");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorPrimary,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Settings"),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Divider(
                height: 2,
                color: AppColor.dark_sky_blue,
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "GENERAL",
                            style: UITextStyle.mediumTextStyle(
                              color: AppColor.heading_text_50,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 2,
                          color: AppColor.heading_text_50,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.notifications_active_outlined,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'Notification',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: Switch(
                            value: Provider.of<SettingsProvider>(context,
                                listen: true)
                                .showNotifications,
                            onChanged: (value) {
                              Provider.of<SettingsProvider>(context,
                                  listen: false)
                                  .toggleNotification();
                            },
                            activeTrackColor: AppColor.heading_text_50,
                            activeColor: AppColor.colorPrimaryDark,
                            inactiveTrackColor: AppColor.heading_text_14,
                          ),
                          onTap: () {},
                        ),
                        dividerWidget(),
                        ListTile(
                          leading: const Icon(
                            Icons.lock_outline_rounded,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'Change Password',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        dividerWidget(),
                        ListTile(
                          leading: const Icon(
                            Icons.payment,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'Payment History',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        dividerWidget(),
                        ListTile(
                          leading: const Icon(
                            Icons.account_balance_wallet_outlined,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'Payment and Payouts',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        dividerWidget(),
                        ListTile(
                          leading: const Icon(
                            Icons.pin_drop_outlined,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'My Address',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {
                            Navigator.of(context).pushNamed(MyAddressScreen.routeName);
                          },
                        ),
                        const Divider(
                          height: 2,
                          color: AppColor.heading_text_50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "CONTACT",
                            style: UITextStyle.mediumTextStyle(
                              color: AppColor.heading_text_50,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 2,
                          color: AppColor.heading_text_50,
                        ),
                        ListTile(
                          leading: const Icon(
                            IcoFontIcons.buildingAlt,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'About Us',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        dividerWidget(),
                        ListTile(
                          leading: const Icon(
                            IcoFontIcons.contacts,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'Contact Us',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        const Divider(
                          height: 2,
                          color: AppColor.heading_text_50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "LEGAL",
                            style: UITextStyle.mediumTextStyle(
                              color: AppColor.heading_text_50,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 2,
                          color: AppColor.heading_text_50,
                        ),
                        ListTile(
                          leading: const Icon(
                            Icons.security,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'Privacy Policy',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        dividerWidget(),
                        ListTile(
                          leading: const Icon(
                            IcoFontIcons.documentFolder,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'Terms & Conditions',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        const Divider(
                          height: 2,
                          color: AppColor.heading_text_50,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Text(
                            "OTHER",
                            style: UITextStyle.mediumTextStyle(
                              color: AppColor.heading_text_50,
                            ),
                          ),
                        ),
                        const Divider(
                          height: 2,
                          color: AppColor.heading_text_50,
                        ),
                        ListTile(
                          leading: const Icon(
                            IcoFontIcons.fileAlt,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'FAQs',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        dividerWidget(),
                        ListTile(
                          leading: const Icon(
                            IcoFontIcons.news,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'Latest Company News',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        dividerWidget(),
                        ListTile(
                          leading: const Icon(
                            IcoFontIcons.questionCircle,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'How Keda Works',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        dividerWidget(),
                        ListTile(
                          leading: const Icon(
                            IcoFontIcons.quillPen,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'Give Us Feedback',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                        dividerWidget(),
                        ListTile(
                          leading: const Icon(
                            IcoFontIcons.home,
                            color: AppColor.heading_text,
                          ),
                          title: Transform.translate(
                            offset: const Offset(-20, 0),
                            child: Text(
                              'Safety Center',
                              style:
                              UITextStyle.semiBoldTextStyle(fontSize: 16),
                            ),
                          ),
                          trailing: const Icon(
                            Icons.keyboard_arrow_right,
                            color: AppColor.heading_text,
                            size: 30,
                          ),
                          onTap: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      _showAlertDialog(context);
                    },
                    label: Text(
                      Translations.of(context).btnLogout,
                      style: UITextStyle.boldTextStyle(
                          letterSpacing: 1.5,
                          fontSize: 16,
                          color: AppColor.whiteColor),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
