import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../controllers/class_controller/splash_controller.dart';
import '../utilities/ui_utility.dart';
import '../widgets/screen_background.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () async {
      if (await SplashController.checkUserState()) {
        Get.offAllNamed("/home");
      } else {
        Get.offAllNamed("/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ScreenBackground(
        child: Center(
          child: SvgPicture.asset(
            UIUtility.logoName,
            width: 120,
          ),
        ),
      ),
    );
  }
}
