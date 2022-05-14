import 'package:flutter/material.dart';
import 'package:keda_flutter/ui/home_screen.dart';
import '../../utils/app_image.dart';
import '../utils/app_color.dart';
import 'authentication/login_screen.dart';

// ignore: must_be_immutable
class SplashScreen extends StatefulWidget {
  var isUserLogin = false;

  SplashScreen({Key? key, required this.isUserLogin}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async {
      Navigator.pushAndRemoveUntil(context,
          MaterialPageRoute(builder: (context) {
            if (widget.isUserLogin) {
              return const HomeScreen();
            } else {
              return const LoginScreen();
            }
          }), (route) => false);
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
                color: AppColor.colorPrimary
            ),
          ),
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset(AppImage.backArrow),
          )
        ],
      ),
    );
  }
}
