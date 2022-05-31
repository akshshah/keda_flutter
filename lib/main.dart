import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:keda_flutter/utils/application_wrapper.dart';

import 'localization/app_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // await Firebase.initializeApp();
  // await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(true);

  final AppModel _appModel = AppModel();

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

