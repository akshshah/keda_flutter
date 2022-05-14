import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../localization/localization.dart';
import '../utils/app_color.dart';
import '../utils/app_image.dart';
import '../utils/enum.dart';
import '../utils/ui_text_style.dart';

class NotificationView extends StatelessWidget {
  final String title;
  final String subTitle;
  final NotificationViewCallback? onTap;

  NotificationView({this.title = "", this.subTitle = "", this.onTap});

  @override
  Widget build(BuildContext context) {
    if (Platform.isAndroid) {
      return Material(
        color: Colors.white,
        child: SafeArea(
          child: GestureDetector(
            child: Container(
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.only(
                      top: 15.h,
                      left: 16.w,
                      right: 16.w,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            ClipRRect(
                              child: Image.asset(
                                AppImage.backArrow,
                                width: 20.w,
                                height: 20.w,
                              ),
                              borderRadius: BorderRadius.circular(4.0),
                            ),
                            SizedBox(
                              width: 6.w,
                            ),
                            Text(
                              Translations.of(context).appName,
                              style: UITextStyle.getTextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: AppColor.heading_text,
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 6.h,
                          ),
                        ),
                        Text(
                          title,
                          style: UITextStyle.getTextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 14,
                            color: AppColor.heading_text,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 6.h,
                          ),
                        ),
                        Text(
                          subTitle,
                          style: UITextStyle.getTextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 12,
                            color: AppColor.heading_text,
                          ),
                          maxLines: 3,
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            top: 10.w,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
              ),
              color: Colors.transparent,
              width: double.infinity,
            ),
            onTap: () {
              if (onTap != null) {
                onTap!(true);
              }
            },
          ),
          bottom: false,
        ),
      );
    } else {
      return Material(
        color: Colors.transparent,
        child: GestureDetector(
          child: SafeArea(
            child: Container(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        ClipRRect(
                          child: Image.asset(
                            AppImage.backArrow,
                            width: 20.w,
                            height: 20.w,
                          ),
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                        SizedBox(
                          width: 6.w,
                        ),
                        Text(
                          Translations.of(context).appName,
                          style: UITextStyle.getTextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 14,
                            color: AppColor.heading_text,
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: 6.h,
                      ),
                    ),
                    Text(
                      title,
                      style: UITextStyle.getTextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColor.heading_text,
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 6)),
                    Text(
                      subTitle,
                      style: UITextStyle.getTextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 13,
                        color: AppColor.heading_text,
                      ),
                      maxLines: 3,
                    ),
                  ],
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                ),
                padding: const EdgeInsets.all(10.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  color: AppColor.whiteColor.withAlpha(200),
                  boxShadow: kElevationToShadow[2],
                ),
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                color: AppColor.whiteColor,
                boxShadow: kElevationToShadow[2],
              ),
              margin: const EdgeInsets.all(10.0),
              width: double.infinity,
            ),
            bottom: false,
          ),
          onTap: () {
            if (onTap != null) {
              onTap!(true);
            }
          },
        ),
      );
    }
  }
}
