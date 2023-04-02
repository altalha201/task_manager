import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../controllers/get_controllers/account_recovery_controller.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/toasts.dart';
import '../utilities/ui_utility.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/dual_text_widget.dart';
import '../widgets/screen_background.dart';
import '../widgets/spacing.dart';

class PinVerificationScreen extends StatelessWidget {
  PinVerificationScreen({Key? key}) : super(key: key);

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
                Text(UIUtility.verificationString, style: authSubtitle(colorLightGray),),
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
                        if (await Get.find<AccountRecoveryController>().checkOTP(pin: _pinField.text.trim())) {
                          Get.toNamed("/setPass");
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
                    Get.offAllNamed("/login");
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
