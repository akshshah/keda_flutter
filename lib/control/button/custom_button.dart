import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utils/app_color.dart';
import '../../utils/ui_text_style.dart';

class CustomButton extends StatelessWidget {
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Color? textColor;
  final Color? bgColor;
  final Color? borderColor;
  final double? radius;
  final double? height;
  final double? width;
  final FontWeight? fontWeight;
  final int? fontSize;
  final String title;
  final Function onTap;

  const CustomButton(
      {required this.title,
      required this.onTap,
      this.textColor,
      this.radius,
      this.height,
      this.width,
      this.bgColor,
      this.borderColor,
      this.margin,
      this.padding,
      this.fontSize,
      this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          height: height ?? 45.h,
            width: width??ScreenUtil().screenWidth,
            alignment: Alignment.center,
            padding: padding ??
                EdgeInsets.symmetric(horizontal: 12.w),
            margin: margin ?? EdgeInsets.zero,
            decoration: BoxDecoration(
                color: bgColor ?? AppColor.colorPrimary,
                border: Border.all(color: borderColor ?? AppColor.transparentColor),
                borderRadius: BorderRadius.all(Radius.circular(radius ?? 24))),
            child: Text(title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: UITextStyle.semiBoldTextStyle(
                    fontSize: fontSize ?? 14,
                    color: textColor ?? AppColor.whiteColor))));
  }
}
