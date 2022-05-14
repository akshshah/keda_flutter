import 'package:flutter_screenutil/flutter_screenutil.dart';

// app constants
final double appbarHeight = 56.h;
const int resendCodeDuration = 30;
const double cameraZoom = 8.0;

// length formatter
const nameMaxLengthFormatter = 50;
const passwordMaxLengthFormatter = 16;
const claimBusinessNameLengthFormatter = 100;
const phoneNumberMaxLengthFormatter = 18;
const otpMaxLengthFormatter = 6;
const zipCodeMaxLengthFormatter = 5;

// reg expressions
RegExp otpFormatter = RegExp('[0-9]');
RegExp phoneNumberFormatter = RegExp('[0-9]');
RegExp amountWithDecimalExpression = RegExp('[0-9.]');
RegExp inputWithNotStartingZero = RegExp('[1-9][0-9]*');
RegExp alphabetFormatterWithSpace = RegExp('[a-zA-Z ]');
RegExp alphabetFormatter = RegExp('[a-zA-Z]');
RegExp businessNameFormatter = RegExp('[a-zA-Z0-9 ]');
RegExp amountFormatter = RegExp(r'^\d+\.?\d{0,2}');
RegExp amountSpecifiedFormatter = RegExp(r'^\d+\.?\d+');
RegExp addMemberNumberFormatter = RegExp(r'[ -()]'); // consider all "space" and "-" characters
RegExp emailRegex = RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>_()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))');
RegExp passwordRegex = RegExp(r"^[a-z0-9A-Z!@#\$%^&*(){}_+*/~`.?<>\-]*");
RegExp phoneNumberRegex = RegExp(r'^[0-9]*$');
RegExp usaPhoneNumberRegex = RegExp(r'^[0-9() -]*');
RegExp nameRegex = RegExp(r"^([a-zA-Z’']+)*");
RegExp nameWithSpaceRegex = RegExp(r"^[a-zA-Z]+([a-zA-Z’' ]+)*");
RegExp userNameRegex = RegExp(r'^[a-zA-Z]+([a-zA-Z0-9]+)*');
RegExp numberOnlyRegex = RegExp(r'^[0-9]*');
RegExp numberWithSpaceRegex = RegExp(r'[0-9]+([0-9 ]+)*');
RegExp numberWithNonZeroRegex = RegExp(r'[1-9]+([0-9]+)*');
RegExp numericNoZeroRegex = RegExp(r'^[1-9]*');
RegExp cardExpiryRegex = RegExp(r'^[0-9/]*');
RegExp charactersOnlyRegex = RegExp(r'^[A-Za-z]*');
RegExp charactersWithSpaceRegex = RegExp(r'^[a-zA-Z]+([a-zA-Z ]+)*');
RegExp charactersWithNumbersRegex = RegExp(r'^[a-z0-9A-Z]+([a-z0-9A-Z]+)*');
RegExp charactersNumbersWithSpaceRegex = RegExp(r'^[a-z0-9A-Z]+([a-z0-9A-Z ]+)*');
RegExp charactersWithSpecialCharacterRegex = RegExp(r'^([A-Za-z0-9!@#%^&_*+/~`.?<>(){}]+)*');
RegExp charactersSpecialCharacterWithSpaceRegex = RegExp(r"^([A-Za-z0-9.’'!@#%^&_*,+/~`?<>(){} \-]+)*");
RegExp floatValueRegex = RegExp(r'^([0-9]+(\.){0,1}[0-9]{0,2})');
RegExp twoSpaceRegex = RegExp(r'^((\ ){2})');

//Other Constant
const cmsTerms = "t&c";
const cmsPrivacy = "policy";
const cmsAboutUs = "about";
