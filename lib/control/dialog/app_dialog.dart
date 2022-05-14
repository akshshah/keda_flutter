import 'package:flutter/material.dart';
import '../../utils/app_color.dart';
import '../../utils/enum.dart';
import '../../utils/ui_text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDialog extends StatefulWidget {
  final String title;
  final String initialButtonText;
  final String endButtonText;
  final Color endButtonColor;
  final CustomAlertActionCallback initActionCallback;
  final CustomAlertActionCallback endActionCallback;
  final double? spacing;

  AppDialog(
      {required this.title,
      required this.initialButtonText,
      required this.endButtonText,
      required this.initActionCallback,
      required this.endActionCallback,
      required this.endButtonColor,
      this.spacing});

  @override
  _AppDialogState createState() => _AppDialogState();
}

class _AppDialogState extends State<AppDialog> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Scaffold(
          key: scaffoldKey,
          backgroundColor: AppColor.transparentColor,
          body: Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              child: Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  Container(
                    // margin: EdgeInsets.symmetric(horizontal: 24.w, vertical: 18.h),
                    margin: EdgeInsets.only(
                        left: 24.w, right: 24.h, top: 20.h, bottom: 8.h),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(widget.title,
                            textAlign: TextAlign.center,
                            style: UITextStyle.regularTextStyle(
                                fontSize: 16, color: AppColor.heading_text)),
                        // SizedBox(height: widget.spacing ?? 8.h),
                        SizedBox(height: 12.h),
                        Row(
                          children: [
                            Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      widget.initActionCallback();
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Text(widget.initialButtonText,
                                            textAlign: TextAlign.center,
                                            style: UITextStyle.regularTextStyle(
                                                fontSize: 16,
                                                color:
                                                    AppColor.colorPrimary))))),
                            SizedBox(width: 16.w),
                            Expanded(
                                child: GestureDetector(
                                    onTap: () {
                                      widget.endActionCallback();
                                    },
                                    child: Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 10.h),
                                        child: Text(widget.endButtonText,
                                            textAlign: TextAlign.center,
                                            style: UITextStyle.regularTextStyle(
                                                fontSize: 16,
                                                color:
                                                    AppColor.colorPrimary)))))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ))),
    );
  }
}
