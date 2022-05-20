import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/login_screen_provider.dart';

import '../../localization/localization.dart';
import '../../ui/authentication/register_screen.dart';
import '../../utils/app_color.dart';
import '../../utils/logger.dart';
import '../../utils/mixin/common_widget.dart';
import '../../utils/styles.dart';
import '../../utils/ui_text_style.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';


class ForgotPasswordScreen extends StatelessWidget {
  ForgotPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();

  static const routeName = '/forgot-password';

  checkValidationAndApiCall(BuildContext context) {
    FocusScope.of(context).unfocus();

    final validationResult = Provider.of<LoginProvider>(context, listen: false).isValidForm2();
    Logger().v("Result $validationResult");
    if (!validationResult.item1) {
      Utils.showSnackBarWithContext(context, validationResult.item2);
      return;
    }

    Utils.showProgressDialog(context);
    Provider.of<LoginProvider>(context, listen: false).forgotPasswordAPI().then((response) async {
      await Utils.dismissProgressDialog(context);
      if(response?.status == 204){
        Utils.showSnackBarWithContext(context, "Incorrect email, phone or password. Please try again.");
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
          appBar: AppBar(),
          body: SingleChildScrollView(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.fromLTRB(24, 0, 24, 24),
              child: Column(
                children: [
                  Text(
                    Translations.of(context).strForgotPassword,
                    style: UITextStyle.boldTextStyle(fontSize: 30, color: AppColor.heading_text),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    Translations.of(context).strForgotDescription,
                    style: UITextStyle.regularTextStyle(fontSize: 17, color: AppColor.heading_text),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonWidget.createTextField(
                      labelText: Translations.of(context).strEmailPhone,
                      controller: _emailController,
                    action:TextInputAction.next,
                    onChanged: Provider.of<LoginProvider>(context, listen: false).forgotFunction,
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  CommonWidget.myFullButton(Translations.of(context).btnSend,  () {
                    checkValidationAndApiCall(context);
                  }),
                  const SizedBox(
                    height: 25,
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
