import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:task_manager/api/network_utils.dart';
import 'package:task_manager/screens/set_password_screen.dart';
import 'package:task_manager/utilities/application_colors.dart';
import 'package:task_manager/utilities/text_styles.dart';
import 'package:task_manager/utilities/toasts.dart';
import 'package:task_manager/utilities/utility_functions.dart';
import 'package:task_manager/widgets/app_elevated_button.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:task_manager/widgets/spacing.dart';

import '../widgets/dual_text_widget.dart';

class PinVerificationScreen extends StatefulWidget {
  final String email;
  const PinVerificationScreen({Key? key, required this.email}) : super(key: key);

  @override
  State<PinVerificationScreen> createState() => _PinVerificationScreenState();
}

class _PinVerificationScreenState extends State<PinVerificationScreen> {

  final _pinField = TextEditingController();

  @override
  Widget build(BuildContext context) {

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
                Text(Utility.verificationString, style: authSubtitle(colorLightGray),),
                verticalSpacing(24.0),
                PinCodeTextField(
                  controller: _pinField,
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
                  beforeTextPaste: (text) {
                    return true;
                  },
                ),
                verticalSpacing(16.0),
                AppElevatedButton(
                    onTap: () async {
                      if (_pinField.text.trim().isNotEmpty) {
                        var navigator = Navigator.of(context);
                        final response = await NetworkUtils().pinVerification(widget.email, _pinField.text.trim());
                        if (response) {
                          navigator.push(
                              MaterialPageRoute(
                                  builder: (context) => SetPasswordScreen(email: widget.email, otp: _pinField.text.trim())));
                        }
                        else {
                          errorToast("OTP doesn't match");
                        }
                      } else {
                        errorToast("OTP doesn't match");
                      }
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
