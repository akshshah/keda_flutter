import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../utils/app_color.dart';

class ProgressDialog extends StatelessWidget {
  const   ProgressDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: SpinKitRing(
          color: AppColor.colorPrimary,
          size: 50.w,
          lineWidth: 5,
        ),
        onWillPop: _onBackSpace);
  }

  Future<bool> _onBackSpace() async {
    return false;
  }
}
