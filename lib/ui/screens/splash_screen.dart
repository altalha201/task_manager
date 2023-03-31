import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../data/auth_utils.dart';
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

    Future.delayed(const Duration(seconds: 2), () {
      checkUserState();
    });

    super.initState();
  }

  Future<void> checkUserState() async {
    final bool userState = await AuthUtils.checkLoginState();
    if (userState) {
      await AuthUtils.getAuthData();
      Get.offAllNamed("/home");
    }
    else {
      Get.offAllNamed("/login");
    }
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
