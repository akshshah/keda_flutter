import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/base_bloc.dart';
import 'package:keda_flutter/service/response/base_response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/api_constant.dart';


class SettingsProvider extends BaseBloc with ChangeNotifier{

  var showNotifications = true;

  toggleNotification(){
    showNotifications = !showNotifications;
    notifyListeners();
  }

  Future<BaseResponse?> logoutAPI() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(PreferenceKey.fcmToken);
    Map<String, dynamic> map = {};
    map["device_token"] = token;
    BaseResponse? response = await repository.logoutApi(map);
    return response;
  }
}