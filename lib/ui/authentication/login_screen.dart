import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keda_flutter/localization/localization.dart';
import 'package:keda_flutter/ui/authentication/register_screen.dart';
import 'package:keda_flutter/utils/app_color.dart';
import 'package:keda_flutter/utils/app_image.dart';
import 'package:keda_flutter/utils/mixin/common_widget.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';

import '../home_screen.dart';
import 'forgot_password_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColor.colorPrimary,
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(24, 40, 24, 10),
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    width: 100,
                    child: Image.asset(
                      AppImage.loginSymbol
                    ),
                  ),
                  const SizedBox(
                    height: 35,
                  ),
                  Text(
                    Translations.of(context).welcome,
                    style: UITextStyle.boldTextStyle(fontSize: 30, color: AppColor.heading_text),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                      Translations.of(context).strLogin,
                    style: UITextStyle.regularTextStyle(fontSize: 18, color: AppColor.heading_text),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CommonWidget.createTextField(
                    labelText: Translations.of(context).strEmailPhone
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CommonWidget.createTextField(
                          labelText: Translations.of(context).strPassword
                      ),
                      Positioned(
                        height: 40,
                        child: TextButton(
                          child: Text(Translations.of(context).strForgotPasswordWithQuestion, style: const TextStyle(fontSize: 15),),
                          onPressed: (){
                            Navigator.of(context).pushNamed(ForgotPasswordScreen.routeName);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  CommonWidget.myFullButton(Translations.of(context).login,  () {
                    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
                  }),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Expanded(
                        flex: 4,
                        child: Divider(
                          thickness: 1,
                          color: AppColor.heading_text_50,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Text("OR", textAlign: TextAlign.center, style: UITextStyle.regularTextStyle(fontSize: 16, color: AppColor.heading_text_50),)
                      ),
                      const Expanded(
                        flex: 4,
                        child: Divider(
                          thickness: 1,
                          color: AppColor.heading_text_50,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: Image.asset(
                          AppImage.google,
                        ),
                      ),
                      SizedBox(
                        width: 70,
                        height: 70,
                        child: Image.asset(
                          AppImage.facebook,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  RichText(
                    text: TextSpan(children: [
                      TextSpan(
                          text: 'Don\'t have an account?',
                          style: UITextStyle.regularTextStyle(
                              color: AppColor.heading_text)),
                      TextSpan(
                        text: ' REGISTER',
                        style: UITextStyle.boldTextStyle(color: AppColor.colorPrimary),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () {
                            Navigator.of(context).pushNamed(RegisterScreen.routeName);
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
