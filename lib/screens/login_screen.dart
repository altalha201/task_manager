import 'package:email_validator/email_validator.dart';
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

  final TextEditingController emailEtLs = TextEditingController();
  final TextEditingController passEtLs = TextEditingController();

  final GlobalKey<FormState> _loginKey = GlobalKey<FormState>();

  bool inProgress = false;

  Future<void> login() async {

    if (_loginKey.currentState!.validate()) {
      setState(() {
        inProgress = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    const proceedIcon = Icons.arrow_circle_right_outlined;

    return Scaffold(
      body: Center(
        child: Scaffold(
          body: ScreenBackground(
              child: inProgress
                  ? const Center(
                      child: CircularProgressIndicator(
                        color: colorGreen,
                      ),
                    )
                  : SafeArea(
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
                                controller: TextEditingController(),
                                validator: (value) {
                                  if (value?.trim().isEmpty ?? true) {
                                    return "Enter Your Email";
                                  } else if (EmailValidator.validate(value!.trim())){
                                    return "Enter a valid Email";
                                  }
                                  return null;
                                },
                            ),
                            verticalSpacing(16.0),
                            AppTextField(
                                hint: "Password",
                                controller: TextEditingController(),
                                validator: (value) {
                                  if ((value?.isEmpty ?? true) || ((value?.length ?? 0) < 8)) {
                                    return "Enter Password with 8 or more characters";
                                  }
                                  return null;
                                },
                            ),
                            verticalSpacing(16.0),
                            AppElevatedButton(
                              onTap: () => login(),
                              child: const Icon(
                                proceedIcon,
                                size: 30,
                              ),
                            ),
                            verticalSpacing(42.0),
                            Container(
                              alignment: Alignment.center,
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(
                                      context, '/emailVerification');
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
                                Navigator.pushNamed(context, "/signUp");
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
