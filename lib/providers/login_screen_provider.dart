import 'package:flutter/material.dart';
import 'package:keda_flutter/providers/base_bloc.dart';
import 'package:keda_flutter/service/api_constant.dart';
import 'package:keda_flutter/service/response/forgot_password_response.dart';
import 'package:keda_flutter/utils/logger.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../service/request/login_request.dart';
import '../service/response/login_response.dart';
import '../utils/validation/validation.dart';



class LoginProvider extends BaseBloc with ChangeNotifier {

  final _emailBehaviorSubject = BehaviorSubject<String>();
  Function(String) get emailFunction => _emailBehaviorSubject.sink.add;

  final _forgetEmailBehaviorSubject = BehaviorSubject<String>();
  Function(String) get forgotFunction => _forgetEmailBehaviorSubject.sink.add;

  final _passwordBehaviorSubject = BehaviorSubject<String>();
  Function(String) get passwordFunction => _passwordBehaviorSubject.sink.add;

  Tuple2<bool, String> isValidForm() {
    List<Tuple2<ValidationType, String>> arrList = [];
    arrList.add(Tuple2(ValidationType.email, _emailBehaviorSubject.value ?? ''));
    arrList.add(Tuple2(ValidationType.password, _passwordBehaviorSubject.value ?? ''));

    final validationResult = Validation().checkValidationForTextFieldWithType(arrList);
    return Tuple2(validationResult.item1, validationResult.item2);
  }

  Future<LoginResponse> loginApi() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString(PreferenceKey.fcmToken);
    LoginRequest request = LoginRequest();
    request.email = _emailBehaviorSubject.value;
    request.password = _passwordBehaviorSubject.value;
    request.deviceToken = token;
    request.userType = 2;
    request.platformType = "android";
    request.registerType = "normal";
    request.tokenExpiry = 0;
    LoginResponse? response = await repository.loginApi(request);
    return response;
  }

  Tuple2<bool, String> isValidForm2() {
    List<Tuple2<ValidationType, String>> arrList = [];
    arrList.add(Tuple2(ValidationType.email, _forgetEmailBehaviorSubject.value ?? ""));

    final validationResult = Validation().checkValidationForTextFieldWithType(arrList);
    return Tuple2(validationResult.item1, validationResult.item2);
  }


  Future<ForgotPasswordResponse?> forgotPasswordAPI() async {
    Map<String, dynamic> map = {};
    map["email"] = _forgetEmailBehaviorSubject.value;
    ForgotPasswordResponse? response = await repository.forgotPasswordApi(map);
    return response;
  }

  @override
  void dispose() {
    _emailBehaviorSubject.close();
    _passwordBehaviorSubject.close();
    _forgetEmailBehaviorSubject.close();
    super.dispose();
  }

}