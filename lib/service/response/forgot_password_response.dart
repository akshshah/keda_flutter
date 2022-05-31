import 'package:keda_flutter/service/response/base_response.dart';

import '../../ui/authentication/models/login_data_model.dart';

class ForgotPasswordResponse extends BaseResponse {
  LoginData? forgotPasswordData;

  ForgotPasswordResponse({int? status, String? message, this.forgotPasswordData}) : super(status: status, message: message);

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    forgotPasswordData = json['data'] != null ? LoginData.fromJson(json['data']) : null;
  }
}

