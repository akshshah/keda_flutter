import 'dart:async';

import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/profile_screen_provider.dart';
import 'package:keda_flutter/ui/authentication/models/login_data_model.dart';
import 'package:keda_flutter/ui/bottomNavigation/test_screen.dart';
import 'package:provider/provider.dart';

import '../../../../utils/app_color.dart';
import '../../../../utils/app_image.dart';
import '../../../../utils/logger.dart';
import '../../../../utils/mixin/common_widget.dart';
import '../../../../utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  EditProfileScreen({Key? key}) : super(key: key);

  static const routeName = "/edit-profile";

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool isFileImage = false;
  LoginData? userData;
  late ProfileProvider profileProvider;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneNumberController = TextEditingController();
  final TextEditingController _aboutMeController = TextEditingController();


  @override
  void initState() {
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    super.initState();
  }


  @override
  void dispose() {
    _emailController.dispose();
    _nameController.dispose();
    _phoneNumberController.dispose();
    _aboutMeController.dispose();
    super.dispose();
  }

  Future<void> getUserDetails(BuildContext context) async {
    Provider.of<ProfileProvider>(context, listen: false).imageFile = null;
    userData = await LoginData.getUserDetails();
    _nameController.text = userData?.username ?? "";
    _emailController.text = userData?.email ?? "";
    _phoneNumberController.text = userData?.mobile ?? "";
    _aboutMeController.text = userData?.aboutUs ?? "";
  }

  callEditUserAPI() {
    FocusScope.of(context).unfocus();

    Utils.showProgressDialog(context);

    String aboutMe = _aboutMeController.text;
    String name = _nameController.text;
    String email = _emailController.text;
    String phone = _phoneNumberController.text;
    profileProvider.editUserAPI(aboutUs: aboutMe, email: email, name: name, phone: phone).then((response) async {
      await Utils.dismissProgressDialog(context);
      Logger().e("Response Code : === ${response.status} " );
      if (response.status == 200) {
        Utils.showSnackBarWithContext(context, response.message?? "");
        Navigator.of(context).pop(true);
      }
      else {
        Utils.showSnackBarWithContext(context, response.message?? "");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).primaryColor,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Edit Profile"),
            bottom: const PreferredSize(
              preferredSize: Size.fromHeight(0),
              child: Divider(
                height: 2,
                color: AppColor.dark_sky_blue,
              ),
            ),
          ),
          body: FutureBuilder(
            future: getUserDetails(context),
            builder: (ctx, snapshot) => snapshot.connectionState == ConnectionState.waiting ? const Center(
              child: CircularProgressIndicator(
                color: AppColor.colorPrimary,
              ),
            ) : SingleChildScrollView(
              child: Container(
                width: double.infinity,
                margin: const EdgeInsets.fromLTRB(24, 24, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        InkWell(
                          onTap: (){
                            profileProvider.checkPermissionAndUploadImage(context);
                          },
                          child: Consumer<ProfileProvider>(
                            builder: (ctx, profileData, child) {
                              return profileData.imageFile != null ? CircleAvatar(
                                  radius: 60,
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: Image.file(
                                      profileData.imageFile!,
                                      width: 120,
                                      height: 120,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                              ) :  Container(
                                height: 120,
                                width: 120,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(200),
                                  child: FadeInImage(
                                    fit: BoxFit.cover,
                                    placeholder: AssetImage(AppImage.personImage),
                                    fadeInDuration: const Duration(milliseconds: 100),
                                    image: NetworkImage(userData?.profilePicture ?? ""),
                                    imageErrorBuilder: (ctx, error, stacktrace ) {
                                      return Image.asset(AppImage.personImage, height: 120, width: 120, fit: BoxFit.cover,);
                                    },
                                  ),
                                ),
                              );
                            },
                          )
                        ),
                        Positioned(
                          bottom: 5,
                          right: 5,
                          child: Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColor.colorPrimary,
                            ),
                            padding: const EdgeInsets.all(5.0),
                            child: const Icon(
                              Icons.photo_camera,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CommonWidget.createTextField(
                      labelText: "Name",
                      action:TextInputAction.next,
                      controller: _nameController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CommonWidget.createTextField(
                      labelText: "Email Address",
                      action:TextInputAction.next,
                      keyboardType: TextInputType.emailAddress,
                      controller: _emailController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CommonWidget.createTextField(
                      labelText: "Phone Number",
                      action:TextInputAction.next,
                      keyboardType: TextInputType.phone,
                      controller: _phoneNumberController,
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    CommonWidget.createTextField(
                      labelText: "About Me",
                      maxLines: 3,
                      action: TextInputAction.newline,
                      keyboardType: TextInputType.multiline,
                      controller: _aboutMeController,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CommonWidget.myFullButton("SAVE",  () {
                      // Navigator.of(context).pushNamed(SimpleS3Test.routeName);
                      callEditUserAPI();
                    }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
