import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/utilities/application_colors.dart';
import 'package:task_manager/utilities/text_styles.dart';
import 'package:task_manager/widgets/app_elevated_button.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:task_manager/widgets/spacing.dart';

import '../widgets/dual_text_widget.dart';

class PinVerificationScreen extends StatefulWidget {
  const PinVerificationScreen({Key? key}) : super(key: key);

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  @override
  Widget build(BuildContext context) {

    const String subtitle = "A 6-digit verification cod will send to your email address";

    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Pin Verification", style: authHeadline(colorDarkBlue),),
                verticalSpacing(8.0),
                Text(subtitle, style: authSubtitle(colorLightGray),),
                verticalSpacing(24.0),
                PinCodeTextField(
                  appContext: context,
                  length: 6,
                  pinTheme: PinTheme(
                    inactiveColor: colorLight,
                    inactiveFillColor: colorWhite,
                    selectedColor: colorGreen,
                    selectedFillColor: colorGreen,
                    activeColor: colorWhite,
                    activeFillColor: colorWhite,
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 45,
                    borderWidth: 0.5
                  ),
                  animationType: AnimationType.fade,
                  animationDuration: const Duration(milliseconds: 300),
                  enableActiveFill: true,
                  onChanged: (value) {},
                ),
                verticalSpacing(16.0),
                AppElevatedButton(
                    onTap: () {
                      Navigator.pushNamed(context, '/setPass');
                    },
                    child: Text("Verify", style: authButton(colorWhite),),
                ),
                verticalSpacing(42.0),
                DualTextWidget(
                  question: "Have account?",
                  todo: "Sign In",
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
