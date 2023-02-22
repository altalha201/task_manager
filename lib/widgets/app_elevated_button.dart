import 'package:flutter/material.dart';

import '../utilities/application_colors.dart';

class AppElevatedButton extends StatelessWidget {

  final VoidCallback onTap;
  final Widget child;

  const AppElevatedButton({
    Key? key,
    required this.onTap,
    required this.child
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: colorGreen,
          padding: const EdgeInsets.all(15.0),
        ),
        onPressed: onTap,
        child: child,
      ),
    );
  }
}
