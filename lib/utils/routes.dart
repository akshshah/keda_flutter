import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/authentication/login_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/profileModule/screens/settings_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/settingsModule/screens/TestScreen.dart';
import 'package:keda_flutter/ui/bottomNavigation/settingsModule/screens/add_address_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/settingsModule/screens/my_address_screen.dart';
import '../ui/authentication/forgot_password_screen.dart';
import '../ui/authentication/register_screen.dart';
import '../ui/home_screen.dart';

// class RouteName {
//   static String login = '/Login';
// }

final Map<String, WidgetBuilder> appRoutes = {
  LoginScreen.routeName : (BuildContext context) => const LoginScreen(),
  RegisterScreen.routeName : (BuildContext context) => const RegisterScreen(),
  ForgotPasswordScreen.routeName : (BuildContext context) => ForgotPasswordScreen(),
  HomeScreen.routeName : (BuildContext context) => const HomeScreen(),
  SettingsScreen.routeName : (BuildContext context) => const SettingsScreen(),
  MyAddressScreen.routeName : (BuildContext context) => const MyAddressScreen(),
  AddAddressScreen.routeName : (BuildContext context) => const AddAddressScreen(),
  MyApp.routeName : (BuildContext context) => MyApp(),
};
