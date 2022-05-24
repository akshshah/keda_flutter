import 'package:keda_flutter/service/response/base_response.dart';

import 'login_response.dart';

class ForgotPasswordResponse extends BaseResponse {
  Data? forgotPasswordData;

  ForgotPasswordResponse({int? status, String? message, this.forgotPasswordData}) : super(status: status, message: message);

  ForgotPasswordResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    forgotPasswordData = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (forgotPasswordData != null) {
      data['data'] = forgotPasswordData!.toJson();
    }
    return data;
  }
}

