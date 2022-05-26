
import 'package:keda_flutter/service/request/login_request.dart';
import 'package:keda_flutter/service/response/forgot_password_response.dart';
import 'package:keda_flutter/service/response/login_response.dart';
import 'package:keda_flutter/service/response/products_response.dart';

import 'api_provider.dart';
import 'response/base_response.dart';

class AppRepository {
  final apiProvider = ApiProvider();

  // Login Api
  Future<LoginResponse> loginApi(LoginRequest params) => apiProvider.loginApi(params);

  //Logout Api
  Future<BaseResponse> logoutApi(Map<String, dynamic> params) => apiProvider.logoutApi(params);

  // //Signup Api
  // Future<SignUpResponse?> signUpApi(SignUpRequest params) => apiProvider.signUpApi(params);

  //Forgot Password Api
  Future<ForgotPasswordResponse?> forgotPasswordApi(Map<String, dynamic> params) => apiProvider.forgotPasswordApi(params);

  //Fetch Saved Products
  Future<ProductsResponse?> fetchSavedProductsAPI(Map<String, dynamic> params) => apiProvider.fetchSavedProducts(params);

  //Fetch Recommended Products
  Future<ProductsResponse?> fetchRecommendedProductsAPI(Map<String, dynamic> params) => apiProvider.fetchRecommendedProducts(params);

  //Fetch Recent search Products
  Future<ProductsResponse?> fetchRecentProducts(Map<String, dynamic> params) => apiProvider.fetchRecentProducts(params);
}
