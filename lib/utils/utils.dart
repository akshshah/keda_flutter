import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:keda_flutter/control/progress_dialog.dart';
import 'package:keda_flutter/ui/bottomNavigation/explore_module/screens/filter_bottom_sheet.dart';
import 'package:keda_flutter/ui/bottomNavigation/explore_module/screens/filter_category_bottom_sheet.dart';
import 'package:keda_flutter/ui/bottomNavigation/explore_module/screens/filter_distance_bottom_sheet.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';
import '../control/alert_widget.dart';
import 'app_color.dart';
import 'enum.dart';
import 'logger.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Utils {
  factory Utils() {
    return _singleton;
  }

  static final Utils _singleton = Utils._internal();
  String get currencyPrefix => 'INR ';

  Utils._internal() {
    Logger().v("Instance created Utils");
  }

  /// Used for update page list
  bool isApiCallRequired = false;

  //region Convert Map
  static Map<String, dynamic> convertMap(dynamic map) {
    Map<dynamic, dynamic> mapDynamic;
    if (map is String) {
      var obj = json.decode(map);
      mapDynamic = obj;
    } else if (map is Map<dynamic, dynamic>) {
      mapDynamic = map;
    } else {
      return <String, dynamic>{};
    }

    Map<String, dynamic> convertedMap = <String, dynamic>{};
    for (dynamic key in mapDynamic.keys) {
      if (key is String) {
        convertedMap[key] = mapDynamic[key];
      }
    }
    return convertedMap;
  }

  //endregion

  //region Alert Control
  static showAlert(BuildContext _context,
      {String? title,
      String? message,
      List<String>? arrButton,
      bool barrierDismissible = true,
      AlertWidgetButtonActionCallback? callback}) {
    Widget alertDialog = AlertWidget(
        title: title,
        message: message,
        buttonOption: arrButton,
        onCompletion: callback);

    if (!barrierDismissible) {
      alertDialog = WillPopScope(
        child: alertDialog,
        onWillPop: () async {
          return false;
        },
      );
    }

    // flutter defined function
    showDialog(
      barrierDismissible: barrierDismissible,
      context: _context,
      builder: (BuildContext context1) {
        return alertDialog;
      },
    );
  }


  //region Alert Control
  // static showAlertWithTextField(BuildContext _context,
  //     {String? title,
  //     String? message,
  //     TextEditingController? textEditingController,
  //     List<String>? arrButton,
  //     bool barrierDismissible = true,
  //       AlertTextFieldWidgetButtonActionCallback? callback}) {
  //   Widget alertDialog = AlertWithTextFieldWidget(
  //       title: title,
  //       message: message,
  //       buttonOption: arrButton,
  //       textEditingController: textEditingController,
  //       onCompletion: callback);
  //
  //   if (!barrierDismissible) {
  //     alertDialog = WillPopScope(
  //       child: alertDialog,
  //       onWillPop: () async {
  //         return false;
  //       },
  //     );
  //   }
  //
  //   // flutter defined function
  //   showDialog(
  //     barrierDismissible: barrierDismissible,
  //     context: _context,
  //     builder: (BuildContext context1) {
  //       return alertDialog;
  //     },
  //   );
  // }
  //endregion

  static void showSnackBar(GlobalKey<ScaffoldState> _key, String? message,
      {int duration = 1, SnackBarAction? action}) {
    if ((message ?? '').isEmpty) {
      return;
    }

    final snackBar = SnackBar(
      content: Text(
        message!,
        style: UITextStyle.getTextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColor.whiteColor,
        ),
      ),
      backgroundColor: AppColor.heading_text,
      duration: Duration(seconds: duration),
      action: action,
    );

    // Remove Current sanckbar if viewed
    ScaffoldMessenger.of(_key.currentContext!).removeCurrentSnackBar();
    ScaffoldMessenger.of(_key.currentContext!).showSnackBar(snackBar);
  }

  static void showSnackBarWithContext(BuildContext context, String message,
      {int duration = 3, SnackBarAction? action}) {
    final text = Text(
      message,
      style: UITextStyle.mediumTextStyle(
        fontSize: 16,
        color: AppColor.whiteColor,
      ),
    );

    final snackBar = SnackBar(
      content: text,
      backgroundColor: AppColor.colorPrimary,
      duration: Duration(seconds: duration),
      action: action,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
    );

    // Remove Current SnackBar if viewed
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  //region Bottom sheet in IOs
  static showBottomSheet(BuildContext _context,
      {String title = '',
      String message = '',
      List<String>? arrButton,
      AlertWidgetButtonActionCallback? callback}) {
    final titleWidget = (title.isNotEmpty)
        ? Text(
            title,
            style: UITextStyle.getTextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColor.heading_text
            ),
          )
        : null;
    final messageWidget = (message.isNotEmpty)
        ? Text(
            message,
            style: UITextStyle.getTextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: AppColor.heading_text),
          )
        : null;

    void onButtonPressed(String btnTitle) {
      int index = (arrButton ?? []).indexOf(btnTitle);
      //dismiss Diloag
      Navigator.of(_context).pop();

      // Provide callback
      if (callback != null) {
        callback(index);
      }
    }

    List<Widget> actions = [];

    for (String str in (arrButton ?? [])) {
      bool isDistructive = (str.toLowerCase() == "delete") || (str.toLowerCase() == "no");
      actions.add(CupertinoDialogAction(
        child: Container(
          child: Text(
            str,
            style: UITextStyle.getTextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 20,
              color: AppColor.heading_text,
            ),
          ),
          alignment: Alignment.center,
          height: 44.h,
        ),
        onPressed: () => onButtonPressed(str),
        isDestructiveAction: isDistructive,
      ));
    }

    final cancelAction = CupertinoDialogAction(
      onPressed: () => onButtonPressed('Cancel'),
      child: Text(
        'Cancel',
        style: UITextStyle.getTextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 20,
            color: AppColor.heading_text),
      ),
    );
    final actionSheet = CupertinoActionSheet(
      title: titleWidget,
      message: messageWidget,
      actions: actions,
      cancelButton: cancelAction,
    );

    showCupertinoModalPopup(
        context: _context,
        builder: (BuildContext context) => actionSheet).then((result) {
      Logger().e("Result :: $result");
    });
  }

  static String getFormattedMaskPhoneNumber({required String input}) {
    String phoneNumber = input;
    phoneNumber = phoneNumber.replaceAll("(", "");
    phoneNumber = phoneNumber.replaceAll(")", "");
    phoneNumber = phoneNumber.replaceAll("-", "");
    phoneNumber = phoneNumber.replaceAll(" ", "");
    phoneNumber = phoneNumber.replaceAll("+", "");

    return phoneNumber;
  }

//endregion

  // static bool isInternetAvailable(GlobalKey<ScaffoldState> key, {bool isInternetMessageRequire = true}) {
  //   bool isInternet = Reachability().isInterNetAvailable();
  //   if (!isInternet && isInternetMessageRequire) {
  //     Utils.showSnackBar(key, Translations.of(key.currentContext!).msgInternetMessage);
  //   }
  //   return isInternet;
  // }

  static void showProgressDialog(BuildContext context) {
    Logger().v("DisPlay Loader");
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (_) => const ProgressDialog());
  }

  static Future dismissProgressDialog(BuildContext context) async {
    /// This Delay Added due to loader open or not
    await Future.delayed(const Duration(milliseconds: 100));
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
    return null;
  }

  // static String getInitialHomeRoute() {
  //   String initialRoute = RouteName.login;
  //   return initialRoute;
  // }

  static Widget buildLoadMoreProgressIndicator() {
    return const Padding(
      padding: EdgeInsets.all(15.0),
      child: Center(
        child: Opacity(
          opacity: 1.0,
          child: SizedBox(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColor.colorPrimary),
              strokeWidth: 2.0,
            ),
            width: 20.0,
            height: 20.0,
          ),
        ),
      ),
    );
  }

  static Future<dynamic> customBottomSheet({required BuildContext context, required String sheetName}){
    return showModalBottomSheet<dynamic>(
        isScrollControlled: true,
        isDismissible: true,
        context: context,
        enableDrag: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16.0),
            topRight: Radius.circular(16.0),
          ),
        ),
        builder: (BuildContext bc) {
          return DraggableScrollableSheet(
              initialChildSize: 0.6,
              maxChildSize: 1 - (AppBar().preferredSize.height / MediaQuery.of(context).size.height),
              minChildSize: 0.4,
              expand: false,
              snap: true,
              snapSizes: const [0.4,],
              builder: (_,controller) {
                switch(sheetName){
                  case "FilterBottomSheet":
                    return FilterBottomSheet(scrollController: controller);
                  case "CategoryBottomSheet":
                    return FilterCategoryBottomSheet(scrollController: controller,);
                  case "MinDistanceBottomSheet":
                    return FilterDistanceBottomSheet(scrollController: controller, distanceType: "Min",);
                  case "MaxDistanceBottomSheet":
                    return FilterDistanceBottomSheet(scrollController: controller, distanceType: "Max",);
                  default:
                    return SizedBox();
                }
              });
        }
    ).then((value) {
      return Future(() => value);
    });
  }
}
