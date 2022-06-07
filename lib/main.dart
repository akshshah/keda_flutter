import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keda_flutter/utils/application_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:keda_flutter/utils/logger.dart';
import 'package:keda_flutter/utils/navigation/navigation_service.dart';

import 'localization/app_model.dart';

const AndroidNotificationChannel channel = AndroidNotificationChannel(
  'fcm_default_channel', // id
  'High Importance Notifications', // name
  description:  'This channel is used for important notifications.', // description
  importance: Importance.high,
);

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  await Firebase.initializeApp();

  final AppModel _appModel = AppModel();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  if(!kIsWeb){
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@drawable/ic_new_notification');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      // iOS: initializationSettingsIOS,
      // macOS: initializationSettingsMacOS,
      // linux: initializationSettingsLinux,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings, onSelectNotification: NavigationService().onSelectNotification );

    /// Create an Android Notification Channel.
    ///
    /// We use this channel in the `AndroidManifest.xml` file to override the
    /// default FCM channel to enable heads up notifications.
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);


    /// Update the iOS foreground notification presentation options to allow
    /// heads up notifications.
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );
  }

  await _appModel.setupInitial();
  runApp(ApplicationWrapper(appModel: _appModel,));

  // runApp(const MyApp());
}

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//           primarySwatch: AppColor.primarySwatch,
//           primaryColor: AppColor.colorPrimary,
//         primaryColorDark: AppColor.colorPrimaryDark,
//         fontFamily: 'Raleway',
//         appBarTheme: const AppBarTheme(
//           backgroundColor: Colors.transparent,
//           elevation: 0.0,
//           foregroundColor: AppColor.colorPrimaryDark
//         )
//       ),
//       debugShowCheckedModeBanner: false,
//       home: const LoginScreen(),
//       routes: routes,
//     );
//   }
// }
//
// var routes = <String, WidgetBuilder>{
//    RegisterScreen.routeName : (BuildContext context) => const RegisterScreen(),
//    ForgotPasswordScreen.routeName : (BuildContext context) => const ForgotPasswordScreen(),
//    HomeScreen.routeName : (BuildContext context) => const HomeScreen(),
// };

