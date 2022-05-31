class EditUserRequest {
  String? aboutUs;
  String? countryCode;
  String? email;
  int? id;
  String? mSelectedMediaPath;
  String? mobile;
  int? notificationStatus;
  String? profilePicture;
  String? registerType;
  int? tokenExpiry = 0;
  String? userName;
  int? userTypeId = 0;

  EditUserRequest(
      {this.aboutUs,
        this.countryCode,
        this.email,
        this.id,
        this.mSelectedMediaPath,
        this.mobile,
        this.notificationStatus,
        this.profilePicture,
        this.registerType ,
        this.tokenExpiry = 0,
        this.userName,
        this.userTypeId = 0});

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['about_us'] = aboutUs;
    data['country_code'] = countryCode;
    data['email'] = email;
    data['id'] = id;
    data['mSelectedMediaPath'] = mSelectedMediaPath;
    data['mobile'] = mobile;
    data['notification_status'] = notificationStatus;
    data['profile_picture'] = profilePicture;
    data['register_type'] = registerType;
    data['token_expiry'] = tokenExpiry;
    data['user_name'] = userName;
    data['user_type_id'] = userTypeId;
    return data;
  }

}