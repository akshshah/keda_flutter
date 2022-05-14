import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../localization/localization.dart';
import '../utils/app_color.dart';
import '../utils/enum.dart';
import '../utils/ui_text_style.dart';

class AlertWidget extends StatefulWidget {
  final String? title;
  final String? message;
  final List<String>? buttonOption;
  final AlertWidgetButtonActionCallback? onCompletion;

  const AlertWidget({this.title, this.message, this.buttonOption, this.onCompletion});

  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWidget> {

  Widget? get titleWidget {
    String mainTitle = widget.title ?? '';
    if (mainTitle.isEmpty) {
      mainTitle = Translations.current?.appName ?? '';
    }

    if (Platform.isIOS) {
      if (mainTitle.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Align(
            alignment: Alignment.topCenter,
            child: Text(
              mainTitle,
              style: UITextStyle.getTextStyle(
                fontWeight: FontWeight.w700,
                color: AppColor.heading_text,
                fontSize: 17,
                letterSpacing: 0.68,
              ),
            ),
          ),
        );
      }
    } else if (Platform.isAndroid) {
      if (mainTitle.isNotEmpty) {
        return Text(
          mainTitle,
          style: UITextStyle.getTextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 17,
            color: AppColor.heading_text,
            letterSpacing: 0.68,
          ),
          textAlign: TextAlign.left,
        );
      }
    }
    return null;
  }

  Widget? get messageWidget {
    if ((widget.message ?? '').isNotEmpty) {
      var messageW = Text(
        widget.message ?? '',
        style: UITextStyle.getTextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 12,
          color: AppColor.heading_text,
          letterSpacing: 0.68,
        ),
      );
      return (Platform.isIOS)
          ? messageW
          : Padding(
              child: messageW,
              padding: const EdgeInsets.only(top: 10.0),
            );
    }
    return null;
  }

  List<Widget> get actionWidget {
    List<Widget> arrButtons = [];

    for (String str in (widget.buttonOption ?? [])) {
      Widget button;
      if (Platform.isIOS) {
        button = CupertinoDialogAction(
          isDestructiveAction: str.toLowerCase() == (Translations.current?.btnCancel ?? '').toLowerCase(),
          child: Text(
            str,
            style: UITextStyle.getTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColor.heading_text,
              letterSpacing: 0.68,
            ),
          ),
          onPressed: () => onButtonPressed(str),
        );
      } else {
        button = TextButton(
          child: Text(
            str,
            style: UITextStyle.getTextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 13,
              color: AppColor.heading_text,
              letterSpacing: 0.68,
            ),
          ),
          onPressed: () => onButtonPressed(str),
        );
      }
      arrButtons.add(button);
    }
    return arrButtons;
  }

  @override
  Widget build(BuildContext context) {
    if (Platform.isIOS) {
      return CupertinoAlertDialog(
        title: titleWidget,
        content: messageWidget,
        actions: actionWidget,
      );
    } else {
      return AlertDialog(
        title: titleWidget,
        content: messageWidget,
        actions: actionWidget,
        backgroundColor: AppColor.whiteColor,
        contentPadding: const EdgeInsets.fromLTRB(24.0, 7.0, 20.0, 12.0),
      );
    }
  }

  void onButtonPressed(String btnTitle) {
    int index = (widget.buttonOption ?? []).indexOf(btnTitle);

    //dismiss Dialog
    Navigator.of(context).pop();

    // Provide callback
    if (widget.onCompletion != null) {
      widget.onCompletion!(index);
    }
  }
}
