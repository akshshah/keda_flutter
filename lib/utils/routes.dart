import 'package:flutter/material.dart';
import '../ui/authentication/forgot_password_screen.dart';
import '../ui/authentication/register_screen.dart';
import '../ui/home_screen.dart';

class RouteName {
  static String login = '/Login';
}

final Map<String, WidgetBuilder> appRoutes = {
  RegisterScreen.routeName : (BuildContext context) => const RegisterScreen(),
  ForgotPasswordScreen.routeName : (BuildContext context) => const ForgotPasswordScreen(),
  HomeScreen.routeName : (BuildContext context) => const HomeScreen(),
};
