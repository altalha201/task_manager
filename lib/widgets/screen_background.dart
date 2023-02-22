import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ScreenBackground extends StatelessWidget {
  final Widget child;
  const ScreenBackground({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;
    const String assetName = "assets/images/background.svg";

    return Stack(
      children: [
        SvgPicture.asset(
          assetName,
          fit: BoxFit.cover,
          height: screenSize.height,
          width: screenSize.width,
        ),
        child,
      ],
    );
  }
}
