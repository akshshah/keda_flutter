import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'zh_local.dart';

class Translations implements WidgetsLocalizations {

  const Translations();

  static Translations? current;

  // Helper method to keep the code in the widgets concise Localizations are accessed using an InheritedWidget "of" syntax
  static Translations of(BuildContext context) {
    return Localizations.of<Translations>(context, Translations) ?? const Translations();
  }

  // Static member to have a simple access to the delegate from the MaterialApp
  static const LocalizationsDelegate<Translations> delegate = _TranslationsDelegate();

  @override
  TextDirection get textDirection => TextDirection.ltr;

  String get appName => 'Keda';

  /* SerVice Message */
  String get msgSomethingWrong => 'Something went wrong.';
  String get msgInternetMessage => 'Internet not available. Please check your internet connection and try again.';
  String get msgSessionExpired => 'Session expired! Please login again.';
  String get msgNoDataFound => 'No Data Found!';

  /* Permission Ask Message */
  String get msgCameraPermissionProfile => "Keda Would Like to Access the Camera.";
  String get msgPhotoPermissionProfile => "Keda Would Like to Access Your Photos.";
  String get msgCameraPermission => 'Keda needs access your camera so you can include a photo in your profile, go to settings and allow access';
  String get msgPhotoPermission => 'Keda needs access to your photos so you can include them in your profile, go to settings and allow access';
  String get msgNotificationPermission => "Keda Would Like to Send You Notifications.Notifications may include alerts, sounds, and icon badges. These can be configured in Settings.";
  String get msgProfilePhotoSelection => 'Keda needs to access your camera or gallery to set your profile picture.';
  String get msgQrCodePhotoSelection => 'Keda needs to access your camera or gallery to set qr code photo.';
  String get msgMicroPhonePermission => 'App needs microphone permission to call, go to settings and allow access';
  String get msgCameraPermissionToCall => 'App needs camera permission to call, go to settings and allow access';
  String get msgCameraPermissionToScanQrCode => 'App needs camera permission to scan code, go to settings and allow access';
  String get msgPhotoPermissionForSave => 'App needs photo permission to save photo in your library, go to settings and allow access';
  String get msgBackAgain => 'Press back again to exit app.';

  /* Media Selection */
  String get strAlert => "Alert";
  String get strTakePhoto => "Take Photo";
  String get strChooseFromExisting => "Choose Photo";
  String get strImage => "Image";
  String get strVideo => "Video";

  /* Common Button List */
  String get btnCancel => 'Cancel';
  String get btnApply => 'Apply';
  String get btnCancelOrder => 'Cancel Order';
  String get btnOk => 'OK';
  String get btnDelete => 'Delete';
  String get btnDecline => 'Decline';
  String get btnSave => 'Save';
  String get btnSubmit => 'SUBMIT';
  String get btnYes => 'Yes';
  String get btnNo => 'No';
  String get btnDone => 'Done';
  String get btnEdit => 'Edit';
  String get btnAdd => 'Add';
  String get btnConfirm => 'Confirm';
  String get btnUpdate => 'Update';

  /* Login Page */
  String get strLogout => 'Logout';
  String get welcome => 'Welcome back!';
  String get strLogin => 'Please login to your account.';
  String get login => 'LOGIN';
  String get strEmail => 'Email';
  String get strEmailPhone => 'Email or Phone Number';
  String get strPassword => 'Password';
  String get strForgotPasswordWithQuestion => 'Forgot?';

 /* Forgot Password Screen*/
  String get strForgotDescription => 'Enter Your username or email address and select ';
  String get strSendEmail => 'Send Email';
  String get strVerify => 'Verify';
  String get strCheckYourEmail => 'Check your email';
  String get strCheckYourEmailDescription => 'You\'ll receive a code to verify here so you can change your account password.';
  String get strNotReceiveCode => 'Didn\'t receive the Code?';
  String get strResend => 'Resend';

  /* Register Screen*/
  String get strCreateAccount => 'Create an Account!';
  String get strRegisterInfo => 'Please fill your details to register.';
  String get strFirstName => 'Name';
  String get strEmailAddress => 'Email Address';
  String get phoneNumber => 'Phone Number';
  String get strConfirmPassword => 'Confirm Password';

  /* validation message */
  String get msgEmptyEmail => "Please enter your email address.";
  String get msgEmptyForgotPasswordEmail => "Please enter your registered email address.";
  String get msgValidEmail => "Please enter valid email address.";
  String get msgEmptyPassword => "Please enter password.";
  String get msgValidPassword => "Please enter minimum 8 character for password.";
  String get msgEmptyReEnterPassword => "Please enter re-enter password.";
  String get msgValidReEnterPassword => "Re-enter password do not match.";
  String get msgEmptyOldPassword => "Please enter current password.";
  String get msgValidOldPassword => "Current password must be 8 characters long.";
  String get msgEmptyNewPassword => "Please enter new password.";
  String get msgPasswordNotMatch => "Password does not match";
  String get msgValidNewPassword => "New password must be 8 characters long.";
  String get msgEmptyVerifyNewPassword => "Please enter verify new password.";
  String get msgValidVerifyNewPassword => "Verify new password must be 8 characters long.";
  String get msgVerifyNewPasswordSame => "The passwords entered do not match";
  String get msgEmptyFirstName => "Please enter first name.";
  String get msgValidFirstName => "Please enter valid first name.";
  String get msgEmptyLastName => "Please enter last name.";
  String get msgValidLastName => "Please enter valid last name.";
  String get msgLogout => "Are you sure you want to log out?";
  String get strEnterDateOfBirth => "Please enter date of birth.";
  String get strEmptyPhone => "Please enter phone number.";
  String get strValidPhone => "Please enter a valid phone number.";
  String get strEmptyUserName => "Please enter your username.";
  String get strValidUserName => "Please enter a valid user name.";
  String get strEnterText => 'Enter Text';

}

class _TranslationsDelegate extends LocalizationsDelegate<Translations> {
  const _TranslationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'ar', 'zh'].contains(locale.languageCode);
  }

  @override
  Future<Translations> load(Locale locale) async {
    // AppLocalizations class is where the JSON loading actually runs
    if (locale.languageCode.toLowerCase() == 'en') {
      Translations.current = const Translations();
      return SynchronousFuture<Translations>(Translations.current ?? const Translations());
    } else if (locale.languageCode.toLowerCase() == 'zh') {
      Translations.current = const $zh();
      return SynchronousFuture<Translations>(Translations.current ?? const $zh());
    }
    Translations.current = const Translations();
    return SynchronousFuture<Translations>(Translations.current ?? const Translations());
  }

  @override
  bool shouldReload(_TranslationsDelegate old) => false;

}
