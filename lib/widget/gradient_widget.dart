import 'package:flutter/material.dart';
import '../utils/app_color.dart';

class GridentWidget {
  static LinearGradient linearGradient(Alignment begin, Alignment end) =>
      LinearGradient(begin: begin, end: end, colors: [
        AppColor.whiteColor,
        AppColor.whiteColor,
        AppColor.colorPrimary,
      ]);
}
