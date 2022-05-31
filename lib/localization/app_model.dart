import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../service/reachability.dart';
import '../ui/authentication/models/login_data_model.dart';
import '../utils/device_utils.dart';
import '../utils/logger.dart';


class AppModel with ChangeNotifier {

  bool isLoading = true;
  bool isUserLogin = false;

  static const Locale enLocale = Locale('en');
  static const Locale arLocale = Locale('ar');
  static const Locale zhLocale = Locale('zh');

  Locale? _appLocale;
  Locale get appLocal => _appLocale ?? AppModel.enLocale;

  AppModel() {
    Logger().v("App Model instance created");
  }

  Future setupInitial() async {
    // SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    //   statusBarColor: AppColor.whiteColor,
    //   statusBarIconBrightness: Brightness.dark,
    //   sta
    // ));
    Logger().v(" ------ Perform Initial Setup ------ ");

    String deviceLocaleCode = Platform.localeName.split('_').first;
    Logger().v("myLocale Cdde : $deviceLocaleCode");

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String cLanguage = prefs.getString("CurrentDeviceLanguage") ?? ((deviceLocaleCode.toLowerCase() != 'zh') ? 'en' : deviceLocaleCode);
    Logger().v("cLanguage Cdde : $cLanguage");

    if (cLanguage == 'zh') {
      _appLocale = AppModel.zhLocale;
    } else {
      _appLocale = AppModel.enLocale;
    }

    /// Wait until setup reachability
    Reachability reachability = Reachability();
    await reachability.setUpConnectivity();
    Logger().v("Network status : ${reachability.connectStatus}");

    // Update Device info
    await DeviceUtil().updateDeviceInfo();

    //Connect platform channel
    // await PlatformChannel().testMethod();

    /// Update FCM Token
    // FireBaseCloudMessagingWrapper messagingWrapper = FireBaseCloudMessagingWrapper();
    // Future.delayed(const Duration(seconds: 3), () async {
    //   await messagingWrapper.getFCMToken();
    // });

    /// User Login Status
    isUserLogin = await LoginData.isUserLogin();
    if (isUserLogin) {
      LoginData.currentUser.loadUserDetails();
    }

    isLoading = false;
    notifyListeners();
  }

  List<Locale> get supportedLocales => [enLocale, arLocale, zhLocale];

  Future changeLanguage({String? languageCode}) async {
    if ((languageCode ?? '').isEmpty) return;
    Logger().i("Current Local changed with language code $languageCode");

    if (languageCode?.toLowerCase() == 'en') { _appLocale = enLocale; }
    if (languageCode?.toLowerCase() == 'ar') { _appLocale = arLocale; }
    if (languageCode?.toLowerCase() == 'zh') { _appLocale = zhLocale; }
    else { _appLocale = enLocale; }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('CurrentDeviceLanguage', (_appLocale?.languageCode ?? '').toLowerCase());
    notifyListeners();
  }
}

extension LocalApi on Locale {
  String get apiLanguageCode {
    if (languageCode == 'en') return 'en';
    if (languageCode == 'zh') return 'cn';
    return 'en';
  }
}