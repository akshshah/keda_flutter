import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingWidget extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return const CircularProgressIndicator(
      strokeWidth: 2.0,
      valueColor: AlwaysStoppedAnimation<Color>(AppColor.colorPrimary),
    );
  }
}


class LoadMoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 20.w,
        width: 20.w,
        margin: EdgeInsets.only(
          top: 10.w,
          bottom: 10.w,
        ),
        child: const CircularProgressIndicator(
          strokeWidth: 2.0,
          valueColor: AlwaysStoppedAnimation<Color>(AppColor.colorPrimary),
        ),
      ),
    );
  }
}