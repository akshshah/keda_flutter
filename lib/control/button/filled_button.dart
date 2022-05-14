import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io' show Platform;
import '../../utils/app_color.dart';
import '../../utils/ui_text_style.dart';

class FilledButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final FontWeight? fontWeight;
  final int? fontSize;
  final double? cornerRadius;
  final BorderRadiusGeometry? borderRadius;
  final double? width;
  final double? height;
  final Color? backgroundColor;
  final Color? textColor;
  final bool? isGradient;
  final LinearGradient? gradient;

  const FilledButton({
    this.title,
    this.onPressed,
    this.fontWeight,
    this.fontSize,
    this.borderRadius,
    this.cornerRadius = 2.0,
    this.width,
    this.height,
    this.backgroundColor,
    this.textColor,
    this.isGradient = false,
    this.gradient,
  });

  BoxDecoration createDecoration() {
    if (isGradient ?? false) {
      return BoxDecoration(
        gradient: gradient ??
            const LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: <Color>[
                AppColor.colorPrimary,
                AppColor.colorPrimary,
              ],
            ),
        borderRadius: borderRadius ??
            BorderRadius.all(
              Radius.circular(cornerRadius ?? 0),
            ),
      );
    } else {
      return BoxDecoration(
        color: backgroundColor ?? AppColor.colorPrimary,
        borderRadius: borderRadius ??
            BorderRadius.all(
              Radius.circular(cornerRadius ?? 0),
            ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final container = Container(
      alignment: Alignment.center,
      width: width ?? double.infinity,
      height: height ?? 65.h,
      child: Text(
        title ?? '',
        style: UITextStyle.getTextStyle(
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: fontSize ?? 16,
          color: textColor ?? AppColor.whiteColor,
        ),
      ),
      decoration: createDecoration(),
    );

    if (Platform.isIOS) {
      return GestureDetector(
        child: container,
        onTap: onPressed,
      );
    } else {
      return InkWell(
        child: container,
        onTap: onPressed,
      );
    }
  }
}
