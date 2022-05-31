import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../service/api_constant.dart';

class LoginData{
  String? refreshToken;
  String? accessToken;
  String? profilePicture;
  String? mobile;
  String? aboutUs;
  String? email;
  String? registerType;
  String? countryCode;
  String? username;
  int? id = 0;
  int? isAccountAdded = 0;
  String? bankAccountStatus;
  int? isCardAdded;
  int? notificationStatus = 1;

  LoginData(
      {id, username, email, mobile, aboutUs, profilePicture, accessToken, registerType,
        countryCode, isAccountAdded, bankAccountStatus, isCardAdded , notificationStatus, refreshToken});

  LoginData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    username = json['user_name'];
    email = json['email'];
    profilePicture = json['profile_picture'];
    refreshToken = json['refresh_token'];
    accessToken = json['token'];
    mobile = json['mobile'];
    aboutUs = json['about_us'];
    registerType = json['register_type'];
    countryCode = json['country_code'];
    isAccountAdded = json['is_acc_added'];
    bankAccountStatus = json['bank_acc_status'];
    isCardAdded = json['is_card_added'];
    notificationStatus = json['notification_status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_name'] = username;
    data['email'] = email;
    data['profile_picture'] = profilePicture;
    data['mobile'] = mobile;
    data['refresh_token'] = refreshToken;
    data['token'] = accessToken;
    data['about_us'] = aboutUs;
    data['register_type'] = registerType;
    data['country_code'] = countryCode;
    data['is_acc_added'] = isAccountAdded;
    data['bank_acc_status'] = bankAccountStatus;
    data['is_card_added'] = isCardAdded;
    data['notification_status'] = notificationStatus;
    return data;
  }

  static LoginData currentUser = LoginData();

  Future<void> updateUserDetail(Map<String, dynamic> json,
      {bool isNeedToSaveDetails = true}) async {
    id = json['id'] ?? id;
    username = json['user_name'] ?? username;
    email = json['email'] ?? email;
    profilePicture = json['profile_picture'] ?? profilePicture;
    refreshToken = json['refresh_token'] ?? refreshToken;
    accessToken = json['token'] ?? accessToken;
    mobile = json['mobile'] ?? mobile;
    aboutUs = json['about_us'] ?? aboutUs;
    registerType = json['register_type'] ?? registerType;
    countryCode = json['country_code'] ?? countryCode;
    isAccountAdded = json['is_acc_added'] ?? isAccountAdded;
    bankAccountStatus = json['bank_acc_status'] ?? bankAccountStatus;
    isCardAdded = json['is_card_added'] ?? isCardAdded;
    notificationStatus = json['notification_status'] ?? notificationStatus;

    if (isNeedToSaveDetails && this == LoginData.currentUser) {
      saveUserDetail();
    }
  }

  static Future<bool> isUserLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storeUserDetails = prefs.getString(PreferenceKey.storeUser);
    return storeUserDetails != null;
  }


  Future<void> saveUserDetail() async {
    final userMap = toJson();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(PreferenceKey.storeUser, json.encode(userMap));
  }

  void loadUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storeUserDetails = prefs.getString(PreferenceKey.storeUser);
    if (storeUserDetails == null) return;
    updateUserDetail(json.decode(storeUserDetails));
  }

  Future<void> resetUserDetail() async {
    id = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PreferenceKey.storeUser);
  }

  static Future<LoginData> getUserDetails() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final userDetails = jsonDecode(prefs.getString(PreferenceKey.storeUser)?? "");
    return LoginData.fromJson(userDetails);
  }

}