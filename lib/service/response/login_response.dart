import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../api_constant.dart';

class LoginResponse {
  int? status;
  String? message;
  Data? loginUserData;

  LoginResponse({this.status, this.message, this.loginUserData});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    loginUserData =
    json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (loginUserData != null) {
      data['data'] = loginUserData!.toJson();
    }
    return data;
  }
}

class Data{
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
  String? isCardAdded;
  int? notificationStatus = 1;

  Data(
      {id, username, email, mobile, aboutUs, profilePicture, accessToken, registerType,
        countryCode, isAccountAdded, bankAccountStatus, isCardAdded , notificationStatus, refreshToken});

  Data.fromJson(Map<String, dynamic> json) {
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
    data['profile_pic'] = profilePicture;
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

  static Data currentUser = Data();

  Future<void> updateUserDetail(Map<String, dynamic> json,
      {bool isNeedToSaveDetails = true}) async {
    id = json['id'] ?? id;
    username = json['user_name'] ?? username;
    email = json['email'] ?? email;
    profilePicture = json['profile_picture'] ?? profilePicture;
    refreshToken = json['refresh_token'] ?? refreshToken;
    accessToken = json['email'] ?? accessToken;
    mobile = json['token'] ?? mobile;
    aboutUs = json['about_us'] ?? aboutUs;
    registerType = json['register_type'] ?? registerType;
    countryCode = json['country_code'] ?? countryCode;
    isAccountAdded = json['is_acc_added'] ?? isAccountAdded;
    bankAccountStatus = json['bank_acc_status'] ?? bankAccountStatus;
    isCardAdded = json['is_card_added'] ?? isCardAdded;
    notificationStatus = json['notification_status'] ?? notificationStatus;

    if (isNeedToSaveDetails && this == Data.currentUser) {
      saveUserDetail();
    }
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

  Future resetUserDetail() async {
    id = null;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(PreferenceKey.storeUser);
  }

}