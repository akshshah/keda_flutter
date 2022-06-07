import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/bottomNavigation/firestore_chat_module/screens/chat_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/profileModule/screens/edit_profile_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/profileModule/screens/profile_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/settingsModule/screens/add_address_screen.dart';
import 'package:keda_flutter/ui/bottomNavigation/settingsModule/screens/my_address_screen.dart';
import '../logger.dart';

class NavigationService {
  static final NavigationService _instance = NavigationService._internal();

  NavigationService._internal() {
    Logger().v("Navigation Service instance created");
  }

  factory NavigationService() {
    return _instance;
  }

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context => NavigationService().navigatorKey.currentState!.overlay!.context;

  Future<dynamic> navigateNamedTo(String routeName,) {
    FocusScope.of(navigatorKey.currentContext!).unfocus();
    return navigatorKey.currentState!.pushNamed(routeName,);
  }

  Future<dynamic> navigateTo<T extends Object>(Route<T> route) {
    FocusScope.of(navigatorKey.currentContext!).unfocus();
    return navigatorKey.currentState!.push(route,);
  }

  Future<dynamic> navigateReplaceTo<T extends Object>(Route<T> route) {
    FocusScope.of(navigatorKey.currentContext!).unfocus();
    return navigatorKey.currentState!.pushReplacement(route,);
  }

  Future<dynamic> navigateRemoveAndUntil<T extends Object>(Route<T> route, Route<T> route1) {
    FocusScope.of(navigatorKey.currentContext!).unfocus();
    return navigatorKey.currentState!.pushAndRemoveUntil(route, (Route<dynamic> routev) => (routev == route1));
  }

  Future<dynamic> navigateRemoveAndUntilNamed(String routeName) {
    return navigatorKey.currentState!.pushNamedAndRemoveUntil(routeName, (_) => false);
  }

  void pop({required int result}) {
    return navigatorKey.currentState!.pop(result);
  }

  Future onSelectNotification(String? payload) async {
    Logger().v("Notification Payload $payload");
    if(payload != null){
      final map = jsonDecode(payload);

      if(map["type"] == "chat"){
        NavigationService().navigateNamedTo(ChatScreen.routeName);
      }
      else if(map["type"] == "profile"){
        NavigationService().navigateNamedTo(MyAddressScreen.routeName);
      }
    }
  }
}
