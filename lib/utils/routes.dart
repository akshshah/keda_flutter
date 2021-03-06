import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/authentication/login_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/screens/auth_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/screens/chat_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/profileModule/screens/edit_profile_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/profileModule/screens/settings_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/settingsModule/screens/add_address_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/settingsModule/screens/my_address_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/test_screen.dart';
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
  EditProfileScreen.routeName : (BuildContext context) => EditProfileScreen(),
  SimpleS3Test.routeName : (BuildContext context) => SimpleS3Test(),
  ChatScreen.routeName : (BuildContext context) => const ChatScreen(),
  AuthScreen.routeName : (BuildContext context) => const AuthScreen(),
};
