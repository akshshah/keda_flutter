import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app_color.dart';
import 'app_font.dart';

class UITextStyle extends Object {
  static TextStyle getTextStyle(
      {String? fontFamily,
      int? fontSize,
      Color? color,
      FontWeight? fontWeight,
      bool isFixed = false,
      double? letterSpacing,
      double? wordSpacing,
      double? lineSpacing,
      TextDecoration? decoration}) {
    double finalFontSize = (fontSize ?? 14).toDouble();
    if (isFixed) {
      finalFontSize = finalFontSize.sp;
    }

    return TextStyle(
        fontSize: finalFontSize,
        fontFamily: fontFamily ?? AppFont.fontRegular,
        color: color ?? AppColor.heading_text,
        letterSpacing: letterSpacing,
        wordSpacing: wordSpacing,
        height: lineSpacing,
        fontWeight: fontWeight,
        decoration: decoration,);
  }

  static boldTextStyle(
      {int? fontSize,
      Color? color,
      double? letterSpacing,
      double? wordSpacing,
      double? lineSpacing,
      TextDecoration? decoration}) {
    return getTextStyle(
      fontFamily: AppFont.fontBold,
      fontSize: fontSize ?? 14,
      color: color ?? AppColor.heading_text,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      lineSpacing: lineSpacing,
      decoration: decoration,
    );
  }

  static semiBoldTextStyle(
      {int? fontSize,
      Color? color,
      double? letterSpacing,
      double? wordSpacing,
      double? lineSpacing,
      TextDecoration? decoration}) {
    return getTextStyle(
      fontFamily: AppFont.fontSemiBold,
      fontSize: fontSize ?? 14,
      color: color ?? AppColor.heading_text,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      lineSpacing: lineSpacing,
      decoration: decoration,
    );
  }

  static semiBoldItalicTextStyle(
      {int? fontSize,
      Color? color,
      double? letterSpacing,
      double? wordSpacing,
      double? lineSpacing,
      TextDecoration? decoration}) {
    return getTextStyle(
      fontFamily: AppFont.fontSemiBoldItalic,
      fontSize: fontSize ?? 14,
      color: color ?? AppColor.heading_text,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      lineSpacing: lineSpacing,
      decoration: decoration,
    );
  }

  static mediumTextStyle(
      {int? fontSize,
      Color? color,
      double? letterSpacing,
      double? wordSpacing,
      double? lineSpacing,
      TextDecoration? decoration}) {
    return getTextStyle(
      fontFamily: AppFont.fontMedium,
      fontSize: fontSize ?? 14,
      color: color ?? AppColor.heading_text,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      lineSpacing: lineSpacing,
      decoration: decoration,
    );
  }

  static regularTextStyle(
      {int? fontSize,
      Color? color,
      double? letterSpacing,
      double? wordSpacing,
      double? lineSpacing,
      TextDecoration? decoration}) {
    return getTextStyle(
      fontFamily: AppFont.fontRegular,
      fontSize: fontSize ?? 14,
      color: color ?? AppColor.heading_text,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      lineSpacing: lineSpacing,
      decoration: decoration,
    );
  }

  static lightTextStyle(
      {int? fontSize,
      Color? color,
      double? letterSpacing,
      double? wordSpacing,
      double? lineSpacing,
      TextDecoration? decoration}) {
    return getTextStyle(
      fontFamily: AppFont.fontLight,
      fontSize: fontSize ?? 14,
      color: color ?? AppColor.heading_text,
      letterSpacing: letterSpacing,
      wordSpacing: wordSpacing,
      lineSpacing: lineSpacing,
      decoration: decoration,
    );
  }
}

class UIHelper extends Object {
  static InputBorder? createBorder({Color? color, double? width}) {
    return UnderlineInputBorder(
      borderSide: BorderSide(
        color: color ?? AppColor.colorPrimary,
        width: width ?? 1.0,
      ),
    );
  }

  EdgeInsets textFieldContentPadding() {
    return EdgeInsets.only(top: 0.h, bottom: 6.h, left: 10.w);
  }

  static EdgeInsets get inputPadding =>
      EdgeInsets.fromLTRB(0.0, 16.h, 10.w, 16.h);

  static TextStyle get inputTextStyle =>
      UITextStyle.regularTextStyle(fontSize: 22);

  static TextStyle get inputLabelStyle =>
      UITextStyle.regularTextStyle(fontSize: 19);

  static TextStyle get inputLabelStyle16 =>
      UITextStyle.regularTextStyle(fontSize: 16);

  static TextStyle get inputTextStyleForRequirementDetail =>
      UITextStyle.regularTextStyle(fontSize: 16);

  static EdgeInsets get customInputPaddingForPostRequirementScreen =>
      const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0);

  static EdgeInsets get customInputPaddingForAddDeliveryScreen =>
      EdgeInsets.fromLTRB(0.0, 8.h, 0.w, 8.h);

  static TextStyle get inputTextStyleForRequirementDetailDisabled =>
      UITextStyle.regularTextStyle(fontSize: 16, color: Colors.grey);
}
