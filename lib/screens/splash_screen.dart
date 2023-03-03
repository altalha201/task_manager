import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      Navigator.pushReplacementNamed(context, "/home");
    });

    super.initState();
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
