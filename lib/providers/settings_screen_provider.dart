import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/base_bloc.dart';
import 'package:keda_flutter/service/response/base_response.dart';
import 'package:keda_flutter/service/response/login_response.dart';

class SettingsProvider extends BaseBloc with ChangeNotifier{

  var showNotifications = true;

  toggleNotification(){
    showNotifications = !showNotifications;
    notifyListeners();
  }

  Future<BaseResponse?> logoutAPI() async {
    Map<String, dynamic> map = {};
    map["device_token"] = "dLTHWwSpSdiNpJQBg7TSM5:APA91bEVZj6TzLG1cG-6YLcoWhYTmxOt8ebT-sriI1erEJ4GmDCx7G-fPwz-LjTMSvY1FUmQYRVhNHZMNdKdCn3wdNnVtWRiRUm92WPw1FrEoN8iMuqo2c0phv857pAUMSro15_gdQ3z";
    BaseResponse? response = await repository.forgotPasswordApi(map);
    return response;
  }
}