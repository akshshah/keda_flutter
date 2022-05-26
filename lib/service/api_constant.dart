import 'dart:io';
import 'package:keda_flutter/service/response/login_response.dart';
import 'package:provider/provider.dart';
import 'package:tuple/tuple.dart';
import '../localization/app_model.dart';
import '../model/user.dart';
import '../utils/device_utils.dart';
import '../utils/firebase_cloud_messaging.dart';
import '../utils/logger.dart';
import '../utils/navigation/navigation_service.dart';

enum ApiType {
  login,
  forgotPassword,
  signUp,
  logout,
  fetchSavedProduct,
  fetchRecommendProduct,
  fetchRecentProduct,
}

class PreferenceKey {
  static String storeUser = "UserDetail";
}

class ApiConstant {

  static String get baseDomain => "https://kedaweb-api.apps.openxcell.dev/api/";
  static String googlePlacesKey = '';

  static String getValue(ApiType type) {
    switch (type) {
      case ApiType.login:
        return 'user/login';
      case ApiType.forgotPassword:
        return 'user/forgotPassword';
      case ApiType.signUp:
        return 'user/add';
      case ApiType.logout:
        return 'user/logout';
      case ApiType.fetchSavedProduct:
        return 'product/favourite/fetch';
      case ApiType.fetchRecommendProduct:
        return 'product/getRecommendedProduct';
      case ApiType.fetchRecentProduct:
        return 'product/fetchRecentSearch';
      default:
        return "";
    }
  }

  /*
  * Tuple Sequence
  * - Url
  * - Header
  * - params
  * - files
  * */
  static Tuple4<String, Map<String, String>, Map<String, dynamic>, List<AppMultiPartFile>?> requestParamsForSync(ApiType type,
      {Map<String, dynamic>? params, List<AppMultiPartFile>? arrFile = const [], String? urlParams}) {
    String apiUrl = ApiConstant.baseDomain + ApiConstant.getValue(type);

    if (urlParams != null) apiUrl = apiUrl + urlParams;

    Map<String, dynamic> paramsFinal = params ?? <String, dynamic>{};
    Map<String, String> headers = <String, String>{};

    AppModel appModel = Provider.of<AppModel>(NavigationService().context, listen: false);
    // headers['language'] = appModel.appLocal.apiLanguageCode;

    if (type == ApiType.login || type == ApiType.signUp) {
      // paramsFinal['deviceType'] = DeviceUtil().deviceType;
      // paramsFinal['deviceId'] = DeviceUtil().deviceId;
      // paramsFinal['fcmToken'] = FireBaseCloudMessagingWrapper().fcmToken;
    }

    if ((Data.currentUser.accessToken != null) && Data.currentUser.accessToken!.isNotEmpty) {
      headers['api-key'] = Data.currentUser.accessToken!;
    }

    Logger().d("Request Start Time :: ${DateTime.now()}");
    Logger().d("Request Url :: $apiUrl");
    Logger().d("Request Params :: $paramsFinal");
    Logger().d("Request headers :: $headers");
    return Tuple4(apiUrl, headers, paramsFinal, arrFile);
  }
}

class AppMultiPartFile {
  List<File> localFiles;
  String key;

  AppMultiPartFile({this.localFiles = const [], this.key = ''});
}
