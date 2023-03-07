import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:task_manager/data/auth_utils.dart';
import 'package:task_manager/widgets/screen_background.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {

    Future.delayed(const Duration(seconds: 2), () {
      checkUserState();
    });

    super.initState();
  }

  Future<void> checkUserState() async {
    final navigator = Navigator.of(context);
    final bool userState = await AuthUtils.checkLoginState();
    if (userState) {
      await AuthUtils.getAuthData();
      navigator.pushNamedAndRemoveUntil("/home", (route) => false);
    }
    else {
      navigator.pushNamedAndRemoveUntil("/login", (route) => false);
    }
  }

  @override
  Widget build(BuildContext context) {

    const String logoName = "assets/images/logo.svg";

    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
            logoName,
            width: 120,
          ),
        ),
      ),
    );
  }
}
