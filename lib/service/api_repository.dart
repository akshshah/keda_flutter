
import 'package:keda_flutter/service/request/login_request.dart';
import 'package:keda_flutter/service/response/forgot_password_response.dart';
import 'package:keda_flutter/service/response/login_response.dart';

import 'api_provider.dart';
import 'response/base_response.dart';

class AppRepository {
  final apiProvider = ApiProvider();

  /* region start */

  // Login Api
  Future<LoginResponse> loginApi(LoginRequest params) => apiProvider.loginApi(params);
  //
  //Logout Api
  Future<BaseResponse> logoutApi(Map<String, dynamic> params) => apiProvider.logoutApi(params);
  //
  // //Signup Api
  // Future<SignUpResponse?> signUpApi(SignUpRequest params) => apiProvider.signUpApi(params);
  //
  //Forgot Password Api
  Future<ForgotPasswordResponse?> forgotPasswordApi(Map<String, dynamic> params) => apiProvider.forgotPasswordApi(params);
  //
  // //Change Password Api
  // Future<BaseResponse> changePasswordApi(ChangePasswordRequest params) => apiProvider.changePasswordApi(params);
  //
  // //Update Profile Api
  // Future<BaseResponse> updateProfileApi(UpdateProfileRequest params) => apiProvider.updateProfileApi(params);
  //
  // //My Profile Api
  // Future<LoginResponse> myProfileApi(MyProfileRequest params) => apiProvider.myProfileApi(params);

/* region end */
}
