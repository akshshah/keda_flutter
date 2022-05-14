import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../localization/localization.dart';
import '../utils/app_color.dart';
import '../utils/enum.dart';
import '../utils/mixin/common_widget.dart';
import '../utils/ui_text_style.dart';
import 'input/text_field_helper.dart';


class AlertWithTextFieldWidget extends StatefulWidget {
  final String? title;
  final String? message;
  final List<String>? buttonOption;
  final AlertTextFieldWidgetButtonActionCallback? onCompletion;
  final TextEditingController? textEditingController;

  AlertWithTextFieldWidget(
      {this.title, this.message, this.buttonOption, this.onCompletion, this.textEditingController});

  @override
  _AlertWidgetState createState() => _AlertWidgetState();
}

class _AlertWidgetState extends State<AlertWithTextFieldWidget> {

  Widget? get titleWidget {
    String mainTitle = widget.title ?? '';
    if (mainTitle.isEmpty) {
      mainTitle = Translations.current?.appName ?? '';
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.topCenter,
        child: CommonWidget.createTextField(
              hintText:
              Translations.of(context).strEnterText,
              controller: widget.textEditingController,
              keyboardType: TextInputType.emailAddress,
              textType: TextFieldType.none,
              action: TextInputAction.done,
              // onChanged: loginBloc.emailFunction,
              // prefixIcon: Image.asset(
              //   AppImage.emailPlaceholder,
              // ),
              textCapitalization: TextCapitalization.none,
              contentPadding:
              UIHelper().textFieldContentPadding(),
              // focusNode: emailFocusNode,
              onEditComplete: () =>
                  FocusScope.of(context).unfocus(),
            ),
      ),
    );
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

    //dismiss Diloag
    Navigator.of(context).pop();

    // Provide callback
    if (widget.onCompletion != null) {
      widget.onCompletion!(index, widget.textEditingController!);
    }
  }
}
