
import 'package:keda_flutter/service/request/login_request.dart';
import 'package:keda_flutter/service/response/login_response.dart';

import 'api_provider.dart';

class AppRepository {
  final apiProvider = ApiProvider();

  /* region start */

  // Login Api
  Future<LoginResponse> loginApi(LoginRequest params) => apiProvider.loginApi(params);
  //
  // //Logout Api
  // Future<BaseResponse> logoutApi() => apiProvider.logoutApi();
  //
  // //Signup Api
  // Future<SignUpResponse?> signUpApi(SignUpRequest params) => apiProvider.signUpApi(params);
  //
  // //Forgot Password Api
  // Future<BaseResponse?> forgotPasswordApi(ForgotPasswordRequest params) => apiProvider.forgotPasswordApi(params);
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
