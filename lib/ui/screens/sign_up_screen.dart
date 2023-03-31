import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/data_utilities.dart';
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

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool inProgress = false;

  void fromFilled() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        inProgress = true;
      });
      final result = await NetworkUtils().postMethod(Urls.registerURL, body: {
        "email": emailController.text.trim(),
        'mobile': phoneController.text.trim(),
        'password': passwordController.text,
        'firstName': firstNameController.text,
        'lastName': lastNameController.text,
      });

      if (result != null && result['status'] == "success") {
        final login = await DataUtilities.login(
            emailController.text.trim(), passwordController.text);
        if (login) {
          Get.offAllNamed("/home");
        } else {
          errorToast("Something went wrong while login. Try From Login later");
        }
      } else {
        errorToast("Something went wrong try again");
      }
      setState(() {
        inProgress = false;
      });
    }
  }

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
                          controller: emailController,
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
                          controller: firstNameController,
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
                          controller: lastNameController,
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
                          controller: phoneController,
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
                          controller: passwordController,
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
                        AppElevatedButton(
                            onTap: () => fromFilled(),
                            child: inProgress
                                ? UIUtility.processing
                                : UIUtility.proceedIcon),
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
