import 'package:flutter/material.dart';

import '../../ui/authentication/register_screen.dart';
import '../../utils/app_color.dart';
import '../../utils/styles.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  static const routeName = '/forgot-password';

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
                  const Text(
                    "Forgot Password?",
                    style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 30,
                        color: AppColor.heading_text),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Please enter your registered email or phone number to receive a verification code.",
                    style: TextStyle(
                        fontWeight: FontWeight.w200,
                        fontSize: 17,
                        color: AppColor.heading_text, ),
                      textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    decoration: Styles.myInputDecoration("Email or Phone Number"),
                    textInputAction: TextInputAction.next,
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(
                    height: 120,
                  ),
                  Styles.myFullButton("SEND", (){

                  }),
                  const SizedBox(
                    height: 25,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Don't have an account?", style: TextStyle(color: AppColor.heading_text),),
                      TextButton(
                          onPressed: (){
                            Navigator.of(context).pushReplacementNamed(RegisterScreen.routeName);
                          },
                          child: const Text("REGISTER", style: TextStyle(fontWeight: FontWeight.w700),))
                    ],
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
