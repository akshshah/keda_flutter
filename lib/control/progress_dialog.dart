import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_color.dart';

class ProgressDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SpinKitRipple(
          color: AppColor.whiteColor,
          size: 100.w,
          borderWidth: 8.0,
        ),
        onWillPop: _onBackSpace);
  }

  Future<bool> _onBackSpace() async {
    return false;
  }
}
