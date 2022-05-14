import 'package:flutter/material.dart';
import '../utils/app_color.dart';
import '../utils/ui_text_style.dart';
import 'loading_widget.dart';

class EmptyListWidget extends StatelessWidget {
  final String? title;
  final bool isLoading;

  EmptyListWidget({this.title, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: isLoading
          ? LoadingWidget()
          : Text(
              title ?? '',
              textAlign: TextAlign.center,
              style: UITextStyle.getTextStyle(
                color: AppColor.heading_text,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
    );
  }
}
