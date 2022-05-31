import 'package:keda_flutter/service/response/base_response.dart';
import 'package:keda_flutter/ui/authentication/models/login_data_model.dart';


class LoginResponse extends BaseResponse {
  LoginData? loginUserData;

  LoginResponse({int? status, String? message, this.loginUserData}) : super(status: status, message: message);

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    loginUserData = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (loginUserData != null) {
      data['data'] = loginUserData!.toJson();
    }
    return data;
  }
}

