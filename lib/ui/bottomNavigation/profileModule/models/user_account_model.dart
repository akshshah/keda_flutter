class UserAccount {
  int? id;
  int? notificationStatus;
  String? userName;
  String? email;
  String? aboutUs;
  String? mobile;
  String? profilePicture;
  String? countryCode;
  String? registerType;
  String? bankAccStatus;
  int? isAccAdded;
  int? isCardAdded;

  UserAccount(
      {this.id,
        this.notificationStatus,
        this.userName,
        this.email,
        this.aboutUs,
        this.mobile,
        this.profilePicture,
        this.countryCode,
        this.registerType,
        this.bankAccStatus,
        this.isAccAdded,
        this.isCardAdded});

  UserAccount.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    notificationStatus = json['notification_status'];
    userName = json['user_name'];
    email = json['email'];
    aboutUs = json['about_us'];
    mobile = json['mobile'];
    profilePicture = json['profile_picture'];
    countryCode = json['country_code'];
    registerType = json['register_type'];
    bankAccStatus = json['bank_acc_status'];
    isAccAdded = json['is_acc_added'];
    isCardAdded = json['is_card_added'];
  }

}