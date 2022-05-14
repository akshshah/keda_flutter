import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keda_flutter/localization/localization.dart';
import 'package:keda_flutter/utils/app_image.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';

import '../../utils/app_color.dart';
import '../../utils/mixin/common_widget.dart';
import '../../utils/styles.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  static const routeName = "/register-screen";

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorPrimary,
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  Text(
                    Translations.of(context).strCreateAccount,
                    style: UITextStyle.boldTextStyle(fontSize: 30, color: AppColor.heading_text)
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      Translations.of(context).strRegisterInfo,
                      style: UITextStyle.regularTextStyle(fontSize: 18, color: AppColor.heading_text_50)
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 120,
                        child: Image.asset(AppImage.personImage),
                      ),
                      Positioned(
                        bottom: 3,
                        right: 3,
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
                      labelText: Translations.of(context).strFirstName
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CommonWidget.createTextField(
                      labelText: Translations.of(context).strEmailAddress
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CommonWidget.createTextField(
                      labelText: Translations.of(context).phoneNumber
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CommonWidget.createTextField(
                      labelText: Translations.of(context).strPassword
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  CommonWidget.createTextField(
                      labelText: Translations.of(context).strConfirmPassword
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Text(
                    "By creating an account you agree to our",
                    style: UITextStyle.regularTextStyle(color: AppColor.heading_text),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Terms of Service",
                        style: UITextStyle.boldTextStyle(
                            color: AppColor.colorPrimary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {

                          },
                      ),
                      TextSpan(
                        text: " & ",
                        style: UITextStyle.regularTextStyle(
                            color: AppColor.heading_text),
                      ),
                      TextSpan(
                        text: "Privacy Policy",
                        style: UITextStyle.boldTextStyle(
                            color: AppColor.colorPrimary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {

                          },
                      ),
                    ]),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonWidget.myFullButton(Translations.of(context).btnSubmit,  () {

                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: "Already have an account? ",
                        style: UITextStyle.regularTextStyle(
                            color: AppColor.heading_text),
                      ),
                      TextSpan(
                        text: "Sign In",
                        style: UITextStyle.boldTextStyle(
                            color: AppColor.colorPrimary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pop();
                          },
                      ),
                    ]),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
