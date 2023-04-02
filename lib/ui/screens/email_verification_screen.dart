import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controllers/account_recovery_controller.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/toasts.dart';
import '../utilities/ui_utility.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/dual_text_widget.dart';
import '../widgets/screen_background.dart';
import '../widgets/spacing.dart';

class EmailVerificationScreen extends StatelessWidget {
  EmailVerificationScreen({Key? key}) : super(key: key);

  final TextEditingController _email = TextEditingController();

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
                Text("Your Email Address", style: authHeadline(colorDarkBlue),),
                verticalSpacing(8.0),
                Text(UIUtility.verificationString, style: authSubtitle(colorLightGray),),
                verticalSpacing(24.0),
                AppTextField(hint: "Email", controller: _email),
                verticalSpacing(16.0),
                AppElevatedButton(
                    onTap: () async {
                      if (_email.text.trim().isNotEmpty) {
                        if (await Get.find<AccountRecoveryController>().sendEmail(email: _email.text.trim())) {
                          successToast("OTP Send to Email");
                          Get.toNamed("/pinVerification");
                        }
                        else {
                          errorToast("Enter a valid email");
                        }
                      }
                      else {
                        errorToast("Enter email");
                      }
                    },
                    child: UIUtility.proceedIcon
                ),
                verticalSpacing(42.0),
                DualTextWidget(
                  question: "Have account?",
                  todo: "Sign In",
                  onTap: () {
                      Get.back();
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
