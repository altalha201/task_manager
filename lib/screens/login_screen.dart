import 'package:flutter/material.dart';
import 'package:task_manager/widgets/app_elevated_button.dart';

import 'package:task_manager/widgets/app_text_field.dart';
import 'package:task_manager/widgets/dual_text_widget.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:task_manager/widgets/spacing.dart';

import '../utilities/text_styles.dart';
import '../utilities/application_colors.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {

    const proceedIcon = Icons.arrow_circle_right_outlined;

    return Scaffold(
      body: Center(
        child: Scaffold(
          body: ScreenBackground(
              child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Get Start With",
                          style: authHeadline(colorDarkBlue),
                        ),
                        verticalSpacing(24),
                        AppTextField(
                            hint: "Email",
                            controller: TextEditingController()
                        ),
                        verticalSpacing(16),
                        AppTextField(
                            hint: "Password",
                            controller: TextEditingController()
                        ),
                        verticalSpacing(16),
                        AppElevatedButton(
                            onTap: () {

                            },
                            child: const Icon(proceedIcon, size: 30,),
                        ),
                        verticalSpacing(42),
                        Container(
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, '/emailVerification');
                            },
                            child: Text(
                              "Forget Password?",
                              style: authTextButton(colorLightGray),
                            ),
                          ),
                        ),
                        verticalSpacing(8),
                        DualTextWidget(
                          question: "Don't Have Account?",
                          todo: "Sign Up",
                          onTap: () {
                            Navigator.pushNamed(context, "/signUp");
                          },
                        ),
                      ],
                    ),
                  )
              ),
          ),
        ),
      ),
    );
  }
}
