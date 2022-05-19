// import 'dart:convert';
// import 'package:shared_preferences/shared_preferences.dart';
// import '../service/api_constant.dart';
//
// class AppUser {
//   int? id;
//   String? role;
//   String? firstname;
//   String? lastname;
//   String? username;
//   String? email;
//   String? emailVerifiedAt;
//   String? googleId;
//   String? profilePic;
//   String? gender;
//   String? phone;
//   int? otp;
//   String? dob;
//   String? location;
//   String? profileheadline;
//   String? profiledescription;
//   String? skill;
//   int? perHourRate;
//   String? language;
//   String? portfolio;
//   String? nationality;
//   String? createdAt;
//   String? updatedAt;
//   String? portfolioPath;
//   String? accessToken;
//
//   AppUser(
//       {id,
//         role,
//         firstname,
//         lastname,
//         username,
//         email,
//         emailVerifiedAt,
//         googleId,
//         profilePic,
//         gender,
//         phone,
//         otp,
//         dob,
//         location,
//         profileheadline,
//         profiledescription,
//         skill,
//         perHourRate,
//         language,
//         portfolio,
//         nationality,
//         portfolioPath,
//         createdAt,
//         updatedAt,
//       this.accessToken});
//
//   static AppUser currentUser = AppUser();
//
//   AppUser.fromJson(Map<String, dynamic> json) {
//     id = json['id'];
//     role = json['role'];
//     firstname = json['firstname'];
//     lastname = json['lastname'];
//     username = json['username'];
//     email = json['email'];
//     emailVerifiedAt = json['email_verified_at'];
//     googleId = json['googleId'];
//     profilePic = json['profile_pic'];
//     gender = json['gender'];
//     phone = json['phone'];
//     otp = json['otp'];
//     dob = json['dob'];
//     location = json['location'] ?? "";
//     profileheadline = json['profileheadline'];
//     profiledescription = json['profiledescription'];
//     skill = json['skill'];
//     perHourRate = json['per_hour_rate'];
//     language = json['language'];
//     portfolio = jsonDecode(json['portfolio']);
//     portfolioPath = json['portfolio_path'];
//     nationality = json['nationality'];
//     createdAt = json['created_at'];
//     updatedAt = json['updated_at'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['id'] = id;
//     data['role'] = role;
//     data['firstname'] = firstname;
//     data['lastname'] = lastname;
//     data['username'] = username;
//     data['email'] = email;
//     data['email_verified_at'] = emailVerifiedAt;
//     data['googleId'] = googleId;
//     data['profile_pic'] = profilePic;
//     data['gender'] = gender;
//     data['phone'] = phone;
//     data['otp'] = otp;
//     data['dob'] = dob;
//     data['location'] = location;
//     data['profileheadline'] = profileheadline;
//     data['profiledescription'] = profiledescription;
//     data['skill'] = skill;
//     data['per_hour_rate'] = perHourRate;
//     data['language'] = language;
//     data['portfolio'] = portfolio;
//     data['portfolio_path'] = portfolioPath;
//     data['nationality'] = nationality;
//     data['created_at'] = createdAt;
//     data['updated_at'] = updatedAt;
//     return data;
//   }
//
//   Future<void> updateUserDetail(Map<String, dynamic> json,
//       {bool isNeedToSaveDetails = true}) async {
//     id = json['id'] ?? id;
//     role = json['role'] ?? role;
//     firstname = json['firstname'] ?? firstname;
//     lastname = json['lastname'] ?? lastname;
//     username = json['username'] ?? username;
//     email = json['email'] ?? email;
//     emailVerifiedAt = json['emailVerifiedAt'] ?? emailVerifiedAt;
//     googleId = json['googleId'] ??googleId;
//     profilePic = json['profile_pic'] ??profilePic;
//     gender = json['gender'] ??gender;
//     phone = json['phone'] ?? phone;
//     otp = json['otp'] ?? otp;
//     dob = json['dob'] ?? dob;
//     location = json['location'] ?? location;
//     profileheadline = json['profileheadline'] ?? profileheadline;
//     profiledescription = json['profiledescription'] ?? profiledescription;
//     skill = json['skill'] ?? skill;
//     perHourRate = json['per_hour_rate'] ?? perHourRate;
//     portfolio = json['portfolio'] ?? portfolio;
//     portfolioPath = json['portfolio_path'] ?? portfolioPath;
//     language = json['language'] ?? language;
//     nationality = json['nationality'] ?? nationality;
//     createdAt = json['createdAt'] ?? createdAt;
//     updatedAt = json['updatedAt'] ?? updatedAt;
//     if (isNeedToSaveDetails && this == AppUser.currentUser) {
//       saveUserDetail();
//     }
//   }
//
//   static Future<bool> isUserLogin() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? storeUserDetails = prefs.getString(PreferenceKey.storeUser);
//     return storeUserDetails != null;
//   }
//
//   void loadUserDetails() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     String? storeUserDetails = prefs.getString(PreferenceKey.storeUser);
//     if (storeUserDetails == null) return;
//     updateUserDetail(json.decode(storeUserDetails));
//   }
//
//   Future<void> saveUserDetail() async {
//     final userMap = toJson();
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.setString(PreferenceKey.storeUser, json.encode(userMap));
//   }
//
//   Future resetUserDetail() async {
//     googleId = null;
//     id = null;
//
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     prefs.remove(PreferenceKey.storeUser);
//   }
// }
