import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../get_controllers/profile_create_controller.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/ui_utility.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/dual_text_widget.dart';
import '../widgets/screen_background.dart';
import '../widgets/spacing.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);

  final emailET = TextEditingController();
  final firstNameET = TextEditingController();
  final lastNameET = TextEditingController();
  final phoneNumberET = TextEditingController();
  final passwordET = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
            child: Center(
              child: Container(
                height: MediaQuery.of(context).size.height,
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Join With Us",
                          style: authHeadline(colorDarkBlue),
                        ),
                        verticalSpacing(24.0),
                        AppTextField(
                          hint: "Email",
                          controller: emailET,
                          validator: (value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Enter Your Email";
                            } else if (!EmailValidator.validate(value!.trim())) {
                              return "Enter a valid Email";
                            }
                            return null;
                          },
                        ),
                        verticalSpacing(16.0),
                        AppTextField(
                          hint: "First Name",
                          controller: firstNameET,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Enter Your First Name";
                            }
                            return null;
                          },
                        ),
                        verticalSpacing(16.0),
                        AppTextField(
                          hint: "Last Name",
                          controller: lastNameET,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return "Enter Your Last Name";
                            }
                            return null;
                          },
                        ),
                        verticalSpacing(16.0),
                        AppTextField(
                          hint: "Mobile Number",
                          controller: phoneNumberET,
                          validator: (value) {
                            if (value?.trim().isEmpty ?? true) {
                              return "Enter Your Phone Number";
                            }
                            return null;
                          },
                        ),
                        verticalSpacing(16.0),
                        AppTextField(
                          hint: "Password",
                          controller: passwordET,
                          obscureText: true,
                          validator: (value) {
                            if ((value?.isEmpty ?? true) &&
                                ((value?.length ?? 0) < 8)) {
                              return "Enter Password with 8 or more characters";
                            }
                            return null;
                          },
                        ),
                        verticalSpacing(16.0),
                        GetBuilder<ProfileCreateController>(builder: (signUp) {
                          return AppElevatedButton(
                              onTap: () {
                                if (_formKey.currentState!.validate()) {
                                  signUp.createProfile(
                                      email: emailET.text.trim(),
                                      mobile: phoneNumberET.text.trim(),
                                      firstName: firstNameET.text,
                                      lastName: lastNameET.text,
                                      password: passwordET.text
                                  );
                                }
                              },
                              child: signUp.inProgress
                                  ? UIUtility.processing
                                  : UIUtility.proceedIcon);
                        }),
                        verticalSpacing(42.0),
                        DualTextWidget(
                          question: "Have an account?",
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
            )),
      ),
    );
  }
}
