import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controllers/auth_controller.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/ui_utility.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/dual_text_widget.dart';
import '../widgets/screen_background.dart';
import '../widgets/spacing.dart';


class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);

  final TextEditingController emailEtLs = TextEditingController();
  final TextEditingController passEtLs = TextEditingController();
  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Scaffold(
          body: ScreenBackground(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _loginKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Get Start With",
                        style: authHeadline(colorDarkBlue),
                      ),
                      verticalSpacing(24.0),
                      AppTextField(
                        hint: "Email",
                        controller: emailEtLs,
                        validator: (value) {
                          if (value?.trim().isEmpty ?? true) {
                            return "Enter Your Email";
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(16.0),
                      AppTextField(
                        hint: "Password",
                        obscureText: true,
                        controller: passEtLs,
                        validator: (value) {
                          if ((value?.isEmpty ?? true) || ((value?.length ?? 0) < 8)) {
                            return "Enter Password with 8 or more characters";
                          }
                          return null;
                        },
                      ),
                      verticalSpacing(16.0),
                      GetBuilder<AuthController>(builder: (authController) {
                        return AppElevatedButton(
                          onTap: () async {
                            if (_loginKey.currentState!.validate()) {
                              final result = await authController.login(
                                  emailEtLs.text.trim(),
                                  passEtLs.text
                              );
                              if (result) {
                                Get.offAllNamed("/home");
                              }
                            }
                          },
                          child: authController.loginInProgress ? UIUtility.processing : UIUtility.proceedIcon
                        );
                      }),
                      verticalSpacing(42.0),
                      Container(
                        alignment: Alignment.center,
                        child: InkWell(
                          onTap: () {
                            Get.toNamed("/emailVerification");
                          },
                          child: Text(
                            "Forget Password?",
                            style: authTextButton(colorLightGray),
                          ),
                        ),
                      ),
                      verticalSpacing(8.0),
                      DualTextWidget(
                        question: "Don't Have Account?",
                        todo: "Sign Up",
                        onTap: () {
                          Get.toNamed("/signUp");
                        },
                      ),
                    ],
                  ),
                ),
            ))),
        ),
      ),
    );
  }
}
