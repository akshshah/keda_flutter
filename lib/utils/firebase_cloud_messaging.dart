import 'dart:convert';
import 'dart:io' show Platform;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:overlay_support/overlay_support.dart';
import '../control/notification_view.dart';
import '../localization/localization.dart';

import 'logger.dart';

class FireBaseCloudMessagingWrapper extends Object {
  FirebaseMessaging? _fireBaseMessaging;
  String _fcmToken = "WDU9hl_B4UWdTfzCP";

  String get fcmToken => _fcmToken;

// Used for identify if navigation instance created
  RemoteMessage? pendingNotification;
  bool _isAppStarted = false;

  factory FireBaseCloudMessagingWrapper() {
    return _singleton;
  }

  static final FireBaseCloudMessagingWrapper _singleton = FireBaseCloudMessagingWrapper._internal();

  String chatMessageType = "new_chat_message";
  String newRequestType = "new_request";
  String acceptRequestType = "accept_request";
  String favouriteType = "favourite";

  FireBaseCloudMessagingWrapper._internal() {
Logger().e("===== Firebase Messaging instance created =====");
    _fireBaseMessaging = FirebaseMessaging.instance;
    firebaseCloudMessagingListeners();
  }

  Future<String> getFCMToken() async {
    try {
      String? token = await _fireBaseMessaging!.getToken();
      if (token != null && token.isNotEmpty) {
        Logger().e("===== FCM Token :: $token =====");
        _fcmToken = token;
      }
      return _fcmToken;
    } catch (e) {
      Logger().e("Error :: ${e.toString()}");
      return e.toString();
    }
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iOSPermission();

    _fireBaseMessaging!.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        if (_isAppStarted) {
          notificationOperation(payload: message);
        } else {
          pendingNotification = message;
        }
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      Logger().v("onMessage :: ${message.toString()}");
      Future.delayed(const Duration(seconds: 1), () => displayNotificationView(payload: message),);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      notificationOperation(payload: message);
    });
  }

  performPendingNotificationOperation() {
    _isAppStarted = true;
    Logger().e("Check Operation for pending notification");
    if (pendingNotification == null) return;
    notificationOperation(payload: pendingNotification);
    pendingNotification = null;
  }

  void iOSPermission() async {
    NotificationSettings settings = await _fireBaseMessaging!.requestPermission(
      alert: true,
      badge: true,
      sound: true,
      criticalAlert: true,
    );
    Logger().e('User granted permission: ${settings.authorizationStatus}');
    _fireBaseMessaging!.getNotificationSettings();
  }

//region notification action view
  void displayNotificationView({RemoteMessage? payload}) {
    String title = payload?.notification?.title?? Translations.current!.appName;
    String body = payload?.notification?.body??"";

    Map<String, dynamic> notification = <String, dynamic>{};
    if (Platform.isIOS) {
      notification = payload!.data;
    } else {
      // notification = payload!.data ?? Map<String, dynamic>();
      notification = payload!.data;
    }
    title = notification["title"] ?? '';
    body = notification["body"] ?? '';

    Logger().v("Display notification view", payload.notification);

    showOverlayNotification((BuildContext _cont) {
      return NotificationView(
          title: title,
          subTitle: body,
          onTap: (isAllow) {
            OverlaySupportEntry.of(_cont)!.dismiss();
            if (isAllow) {
              notificationOperation(payload: payload);
            }
          });
    }, duration: Duration(milliseconds: 5000));
  }

//endregion

//region notificationOperation or input action
  void notificationOperation({RemoteMessage? payload}) {
    Logger().v(" Notification On tap Detected ");
    Logger().e("====== Notification content =====${payload!.data}======");
    var data;
    Map<String, dynamic> notification = <String, dynamic>{};
    if (payload.data['data'] is String) {
      data = json.decode(payload.data['data']);
      Logger().d("===========$data======");
      if (Platform.isIOS) {
        notification = data;
      } else {
        notification = data ?? <String, dynamic>{};
      }
    } else {
      if (Platform.isIOS) {
        notification = payload.data;
      } else {
        // notification = payload.data ?? Map<String, dynamic>();
        notification = payload.data;
      }
    }

//     String id = notification["id"];
//     String type = notification['type'] ?? '';
  }
}
