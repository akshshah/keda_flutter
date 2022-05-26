import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:keda_flutter/providers/explore_screen_provider.dart';
import 'package:keda_flutter/providers/login_screen_provider.dart';
import 'package:keda_flutter/providers/saved_screen_provider.dart';
import 'package:keda_flutter/providers/settings_screen_provider.dart';
import 'package:keda_flutter/utils/app_font.dart';
import 'package:keda_flutter/utils/ui_text_style.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';

import '../localization/app_model.dart';
import '../localization/localization.dart';
import '../providers/base_bloc.dart';
import '../ui/splash_screen.dart';
import '../utils/navigation/navigation_service.dart';
import 'app_color.dart';
import 'routes.dart';

class ApplicationWrapper extends StatelessWidget {
  final AppModel appModel;

  const ApplicationWrapper({Key? key, required this.appModel})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppModel>.value(
      value: appModel,
      child: Consumer<AppModel>(
        builder: (context, value, child) {
          return MultiProvider(
            providers: [
              Provider<BaseBloc>.value(value: BaseBloc()),
              ChangeNotifierProvider(create: (ctx) => LoginProvider()),
              ChangeNotifierProvider(create: (ctx) => SettingsProvider()),
              ChangeNotifierProvider(create: (ctx) => SavedProvider()),
              ChangeNotifierProvider(create: (ctx) => ExploreProvider()),
            ],
            child: ScreenUtilInit(
              designSize: const Size(375, 812),
              builder: (context) {
                return OverlaySupport.global(
                  child: MaterialApp(
                    onGenerateTitle: (BuildContext _context) =>
                        Translations.of(_context).appName,
                    // localizationsDelegates: const [
                    //   Translations.delegate,
                    //   FallbackCupertinoLocalisationsDelegate(),
                    //   GlobalMaterialLocalizations.delegate,
                    //   GlobalWidgetsLocalizations.delegate,
                    // ],
                    locale: value.appLocal,
                    debugShowCheckedModeBanner: false,
                    supportedLocales: value.supportedLocales,
                    builder: (context, child) => MediaQuery(
                      child: child ?? Container(),
                      data:
                          MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    ),
                    theme: ThemeData(
                      primarySwatch: AppColor.primarySwatch,
                      primaryColor: AppColor.colorPrimary,
                      primaryColorDark: AppColor.colorPrimaryDark,
                      fontFamily: AppFont.fontRegular,
                      appBarTheme: AppBarTheme(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        titleTextStyle: UITextStyle.boldTextStyle(fontSize: 18),
                        foregroundColor: AppColor.heading_text,
                      ),
                    ),
                    home: SplashScreen(isUserLogin: value.isUserLogin),
                    routes: appRoutes,
                    navigatorKey: NavigationService().navigatorKey,
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
