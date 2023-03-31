import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/toasts.dart';
import '../utilities/ui_utility.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/dual_text_widget.dart';
import '../widgets/screen_background.dart';
import '../widgets/spacing.dart';

class EmailVerificationScreen extends StatefulWidget {
  const EmailVerificationScreen({Key? key}) : super(key: key);

  @override
  State<EmailVerificationScreen> createState() => _EmailVerificationScreenState();
}

class _EmailVerificationScreenState extends State<EmailVerificationScreen> {

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
                        final response = await NetworkUtils().getMethod(url: Urls.recoveryEmail(_email.text.trim()));
                        if (response['status'] == "success") {
                          successToast("OTP Send to Email");
                          Get.toNamed("/pinVerification", arguments: {'email' : _email.text.trim()});
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
