import 'dart:io';
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
  logout,
  forgotPassword,
  signUp,
  changePassword,
  updateProfile,
  myProfile,
}

class PreferenceKey {
  static String storeUser = "UserDetail";
}

class ApiConstant {

  static String get baseDomain => 'https://ishaanadvisory.in/work/';
  static String googlePlacesKey = '';

  static String getValue(ApiType type) {
    switch (type) {
      case ApiType.login:
        return 'api/login';
      case ApiType.logout:
        return '/api/logout';
      case ApiType.changePassword:
        return 'api/change-password';
      case ApiType.forgotPassword:
        return 'api/forgot';
      case ApiType.signUp:
        return 'api/register';
      case ApiType.updateProfile:
        return 'api/update-profile';
      case ApiType.myProfile:
        return 'api/my-profile';
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
    headers['language'] = appModel.appLocal.apiLanguageCode;

    if (type == ApiType.login || type == ApiType.signUp) {
      paramsFinal['deviceType'] = DeviceUtil().deviceType;
      paramsFinal['deviceId'] = DeviceUtil().deviceId;
      paramsFinal['fcmToken'] = FireBaseCloudMessagingWrapper().fcmToken;
    }

    if ((AppUser.currentUser.accessToken != null) && AppUser.currentUser.accessToken!.isNotEmpty) {
      headers['Authorization'] = AppUser.currentUser.accessToken!;
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
