import 'dart:async';
import 'dart:convert';
import 'dart:io' show File;
import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:keda_flutter/service/request/login_request.dart';
import 'package:keda_flutter/service/response/forgot_password_response.dart';
import 'package:keda_flutter/service/response/login_response.dart';
import 'package:path/path.dart';
import '../localization/localization.dart';
import '../model/user.dart';
import '../utils/logger.dart';
import '../utils/navigation/navigation_service.dart';
import '../utils/routes.dart';
import '../utils/utils.dart';
import 'api_constant.dart';
import 'base_response.dart';
import 'reachability.dart';
import 'package:mime/mime.dart';

class HttpResponse {
  int status;
  String? errMessage = "";
  dynamic json;
  bool failDueToToken;

  HttpResponse({required this.status, required this.errMessage, this.json, this.failDueToToken = false});
}

class ResponseKeys {
  static String kMessage = 'message';
  static String kStatus = 'status';
  static String kId = 'id';
  static String kData = 'data';
}

class ApiProvider {
  CancelToken? lastRequestToken;

  factory ApiProvider() {
    return _singleton;
  }

  final Dio dio = Dio();
  static final ApiProvider _singleton = ApiProvider._internal();

  ApiProvider._internal() {
    Logger().v("Instance created ApiProvider");
    // Setting up connection and response time out
    dio.options.connectTimeout = 180 * 1000;
    dio.options.receiveTimeout = 120 * 1000;
  }

  void performLogoutOperation() async {
    Utils.showAlert(
      NavigationService().context,
      title: Translations.current?.appName ?? '',
      message: Translations.current?.msgSessionExpired ?? '',
      arrButton: [Translations.current?.btnOk ?? ''],
      barrierDismissible: false,
      callback: (index) async {
        await Data.currentUser.resetUserDetail();
        NavigationService().navigateRemoveAndUntilNamed(RouteName.login);
      },
    );
  }

  Future<HttpResponse> _handleDioNetworkError(DioError error, ApiType apiType) async {
    Logger().v("Error Details :: ${error.message}");

    if ((error.response == null) || (error.response?.data == null)) {
      return HttpResponse(status: 500, errMessage: Translations.current?.msgSomethingWrong ?? '');
    } else {
      Logger().v("Error Details :: ${error.response?.data}");
      dynamic jsonResponse = error.response?.data;
      if (jsonResponse is Map) {

        final status = jsonResponse[ResponseKeys.kStatus] ?? 400;

        if (status == 417 || error.response?.statusCode == 417 || error.response?.statusCode == 401) { // Need To Log Out
          Future.delayed(const Duration(milliseconds: 1000), () => performLogoutOperation());
          String errMessage = jsonResponse["message"] ?? (Translations.current?.msgSomethingWrong ?? '');
          return HttpResponse(status: status, errMessage:  errMessage, json: null);
        } else {
          String errMessage = jsonResponse["message"] ?? (Translations.current?.msgSomethingWrong ?? '');
          return HttpResponse(status: status, errMessage:  errMessage, json: null);
        }
      } else {
        if (error.response?.statusCode == 401) {
          Future.delayed(const Duration(milliseconds: 1000), () => performLogoutOperation());
        }
        return HttpResponse(status: 500, errMessage: Translations.current?.msgSomethingWrong ?? '', json: null);
      }
    }
  }

  HttpResponse _handleNetworkSuccess({required Response<dynamic> response}) {
    dynamic jsonResponse = response.data;
    Logger().d("Request End Time :: ${DateTime.now()}");
    Logger().d("Response Status code:: ${response.statusCode}");
    Logger().d("response body :: $jsonResponse");

    final message = jsonResponse[ResponseKeys.kMessage] ?? '';
    final status = jsonResponse[ResponseKeys.kStatus] ?? response.statusCode;
    final data = jsonResponse[ResponseKeys.kData] ?? "";
    if ((response.statusCode ?? 0) >= 200 && (response.statusCode ?? 0) < 299) {
      return HttpResponse(status: status, errMessage: message, json: data);
    } else {
      var errMessage = jsonResponse[ResponseKeys.kMessage];
      return HttpResponse(status: status, errMessage: errMessage, json: jsonResponse);
    }
  }


  //region API Request Helper
  Future<HttpResponse> getRequest(ApiType apiType, {Map<String, String>? params, String? urlParam}) async {
    if (!Reachability().isInterNetAvailable()) {
      return HttpResponse(status: 101, errMessage: Translations.current?.msgInternetMessage ?? '');
    }

    final requestFinal = ApiConstant.requestParamsForSync(apiType, params: params, urlParams: urlParam);
    lastRequestToken = CancelToken();
    final option = Options(headers: requestFinal.item2);
    try {
      final response = await dio.get(requestFinal.item1, queryParameters: requestFinal.item3, options: option, cancelToken: lastRequestToken);
      return _handleNetworkSuccess(response: response);
    } on DioError catch (error) {
      final result = await _handleDioNetworkError(error, apiType);
      if (result.failDueToToken) {
        return getRequest(apiType, params: params, urlParam: urlParam);
      }
      return result;
    }
  }

  Future<HttpResponse> postRequest(ApiType apiType, {Map<String, dynamic>? params,}) async {
    if (!Reachability().isInterNetAvailable()) {
      return HttpResponse(status: 101, errMessage: Translations.current?.msgInternetMessage ?? '');
    }

    final requestFinal = ApiConstant.requestParamsForSync(apiType, params: params);
    final option = Options(headers: requestFinal.item2);
    lastRequestToken = CancelToken();
    try {
      final response = await dio.post(requestFinal.item1, data: json.encode(requestFinal.item3), options: option, cancelToken: lastRequestToken);
      return _handleNetworkSuccess(response: response);
    } on DioError catch (error) {
      final result = await _handleDioNetworkError(error, apiType);

      if (result.failDueToToken) {
        return postRequest(apiType, params: params,);
      }
      return result;
    }
  }

  Future<HttpResponse> uploadRequest(ApiType apiType, {Map<String, dynamic>? params, List<AppMultiPartFile>? arrFile, String? urlParam}) async {
    if (!Reachability().isInterNetAvailable()) {
      final httpResonse = HttpResponse(status: 101, errMessage: Translations.current?.msgInternetMessage ?? '');
      return httpResonse;
    }

    final requestFinal = ApiConstant.requestParamsForSync(apiType, params: params, arrFile: arrFile);


    // Create form data Request
    FormData formData = FormData.fromMap(requestFinal.item3);

    /* Adding File Content */
    for (AppMultiPartFile partFile in (requestFinal.item4 ?? [])) {
      for (File file in partFile.localFiles) {
        Logger().v("File Path :: ${file.path}");
        bool fileExists = await file.exists();
        if (fileExists) {
          String filename = basename(file.path);
          String? mineType = lookupMimeType(filename);
          String extensionFile = extension(file.path);
          if (mineType == null) {
            if (extensionFile == '.m4a') {
              MultipartFile mFile = await MultipartFile.fromFile(file.path, filename: filename, contentType: MediaType('audio', 'm4a'));
              formData.files.add(MapEntry(partFile.key, mFile));
            } else {
              MultipartFile mFile = await MultipartFile.fromFile(file.path, filename: filename,);
              formData.files.add(MapEntry(partFile.key, mFile));
            }
          } else {
            MultipartFile mFile = await MultipartFile.fromFile(file.path, filename: filename, contentType: MediaType(mineType.split("/").first, mineType.split("/").last));
            formData.files.add(MapEntry(partFile.key, mFile));
          }
        }
      }
    }

    /* Create Header */
    final option = Options(headers: requestFinal.item2);

    try {
      final response = await dio.post(requestFinal.item1, data: formData, options: option, onSendProgress: (sent, total) => Logger().v("uploadFile ${sent / total}"));
      return _handleNetworkSuccess(response: response);
    } on DioError catch (error) {
      final result = await _handleDioNetworkError(error, apiType);
      if (result.failDueToToken) {
        return uploadRequest(apiType, params: params, arrFile: arrFile, urlParam: urlParam);
      }
      return result;
    }
  }
  //endregion


  //Login API
  Future<LoginResponse> loginApi( LoginRequest params) async {
    final HttpResponse response = await postRequest(ApiType.login, params: params.toJson());
    Data? user;
    Logger().v("Response Code in login API: === ${response.status} " );
    if ((response.status == 200) && (response.json is Map)) {
      user = Data.currentUser;
      user.updateUserDetail(response.json);
      await user.saveUserDetail();
    }
    else if(response.status == 204){
      return LoginResponse(status: response.status, message: "", loginUserData: null);
    }
    return LoginResponse(status: response.status, message: response.errMessage, loginUserData: user);
  }

  //Forgot Password API
  Future<ForgotPasswordResponse?> forgotPasswordApi(Map<String, dynamic> params) async {
    final HttpResponse response = await postRequest(ApiType.forgotPassword, params: params);
    Logger().v("Response Code in forgot Password API: === ${response.status} " );
    ForgotPasswordResponse? forgotPasswordResponse;
    if ((response.status == 200) && (response.json is Map)) {
      forgotPasswordResponse = ForgotPasswordResponse.fromJson(response.json);
    }
    return ForgotPasswordResponse(status: response.status, message: response.errMessage, forgotPasswordData: forgotPasswordResponse?.forgotPasswordData);
  }
  //
  // //Logout API
  // Future<BaseResponse> logoutApi() async {
  //   final HttpResponse response = await postRequest(ApiType.logout);
  //   return BaseResponse(status: response.status, message: response.errMessage);
  // }
  //
  // //Signup API
  // Future<SignUpResponse?> signUpApi(SignUpRequest params) async {
  //   final HttpResponse response = await postRequest(ApiType.signUp, params: params.toJson());
  //   AppUser? user;
  //   if ((response.status == 200) && (response.json is Map)) {
  //     user = AppUser.currentUser;
  //     user.updateUserDetail(response.json);
  //     await user.saveUserDetail();
  //   }
  //   return SignUpResponse(status: response.status, message: response.errMessage, data: user);
  // }
  //
  // //Change Password Api
  // Future<BaseResponse> changePasswordApi(ChangePasswordRequest params) async {
  //   final HttpResponse response = await postRequest(ApiType.changePassword, params: params.toJson());
  //   return BaseResponse(status: response.status, message: response.errMessage);
  // }
  //
  // //Update Profile API
  // Future<BaseResponse> updateProfileApi(UpdateProfileRequest params) async {
  //   final HttpResponse response = await uploadRequest(ApiType.updateProfile,arrFile: params.files, params: params.toJson());
  //   if ((response.status == 200) && (response.json is Map)) {
  //     return BaseResponse(status: response.status,message: response.errMessage);
  //   }
  //   return BaseResponse(status: response.status,message: response.errMessage);
  // }
  //
  // //My Profile API
  // Future<LoginResponse> myProfileApi(MyProfileRequest params) async {
  //   final HttpResponse response = await postRequest(ApiType.myProfile, params: params.toJson());
  //   AppUser? user;
  //   if ((response.status == 200) && (response.json is Map)) {
  //     user = AppUser.currentUser;
  //     user.updateUserDetail(response.json);
  //     await user.saveUserDetail();
  //   }
  //   return LoginResponse(status: response.status, message: response.errMessage, loginUserData: user);
  // }
}
