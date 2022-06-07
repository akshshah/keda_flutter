
import 'package:keda_flutter/service/request/edit_user_request.dart';
import 'package:keda_flutter/service/request/login_request.dart';
import 'package:keda_flutter/service/request/send_chat_request.dart';
import 'package:keda_flutter/service/response/chat_response.dart';
import 'package:keda_flutter/service/response/forgot_password_response.dart';
import 'package:keda_flutter/service/response/login_response.dart';
import 'package:keda_flutter/service/response/products_response.dart';
import 'package:keda_flutter/service/response/user_account_status_response.dart';
import 'package:keda_flutter/service/response/user_rate_review_response.dart';

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

  //Fetched User Rate & Review
  Future<UserRateReviewResponse?> fetchUserRateReview(Map<String, dynamic> params) => apiProvider.fetUserRateReview(params);

  //Fetched User Account Status API
  Future<UserAccountStatusResponse?> fetchUserAccountStatus(Map<String, dynamic> params) => apiProvider.fetchUserAccountStatus(params);

  //Fetched User Products API
  Future<ProductsResponse?> fetchUserProductsAPI(Map<String, dynamic> params) => apiProvider.fetchUserProducts(params);

  //Edit User API
  Future<LoginResponse> editUserAPI(EditUserRequest request) => apiProvider.editUserAPI(request);

  //Send Chat Message API
  Future<ChatResponse> sendChatMessageAPI(SendChatRequest request) => apiProvider.sendChatMessageAPI(request);
}
