class LoginRequest{
  String? email;
  String? password;
  int userType = 2;
  String? deviceToken;
  String? platformType;
  String? registerType;
  int tokenExpiry = 0;

  LoginRequest({this.email, this.password, this.userType = 2, this.registerType,
    this.deviceToken, this.platformType, this.tokenExpiry = 0});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['user_type_id'] = userType;
    data['device_token'] = deviceToken;
    data['platform_type'] = platformType;
    data['register_type'] = registerType;
    data['token_expiry'] = tokenExpiry;

    return data;
  }
}