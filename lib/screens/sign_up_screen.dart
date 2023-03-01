import 'package:flutter/material.dart';
import 'package:task_manager/api/api_client.dart';
import 'package:task_manager/utilities/application_colors.dart';
import 'package:task_manager/utilities/text_styles.dart';
import 'package:task_manager/utilities/toasts.dart';
import 'package:task_manager/utilities/urls.dart';
import 'package:task_manager/widgets/app_elevated_button.dart';
import 'package:task_manager/widgets/app_text_field.dart';
import 'package:task_manager/widgets/dual_text_widget.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:task_manager/widgets/spacing.dart';

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

  void clearAll() {
    emailController.clear();
    phoneController.clear();
    firstNameController.clear();
    lastNameController.clear();
    passwordController.clear();
  }

  void fromFilled() async {
    if (_formKey.currentState!.validate()){
      setState(() {
        inProgress = true;
      });
      final result = await NetworkUtils().postMethod(
        Urls.registerURL,
        body: {
          "email" : emailController.text.trim(),
          'mobile': phoneController.text.trim(),
          'password': passwordController.text,
          'firstName': firstNameController.text,
          'lastName': lastNameController.text,
        }
      );

      setState(() {
        inProgress = false;
      });

      if (result != null && result['status'] == "success") {
        clearAll();
        successToast("Registration Complete");
      } else {
        errorToast("Something went wrong try again");
      }

    }
  }

  @override
  Widget build(BuildContext context) {
    const proceedIcon = Icons.arrow_circle_right_outlined;

    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
            child: inProgress
                ? const Center(
                    child: CircularProgressIndicator(color: colorGreen,),
                  )
                : SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.all(24.0),
                      child: Form(
                        key: _formKey,
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
                                  if (value?.trim().isEmpty ?? true){
                                    return "Enter Your Email";
                                  }
                                  return null;
                                },
                            ),
                            verticalSpacing(16.0),
                            AppTextField(
                                hint: "First Name",
                                controller: firstNameController,
                                validator: (value) {
                                  if (value?.isEmpty ?? true){
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
                                  if (value?.isEmpty ?? true){
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
                                if (value?.trim().isEmpty ?? true){
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
                                    ((value?.length ?? 0) < 8)){
                                  return "Enter Password with 8 or more characters";
                                }
                                return null;
                              },
                            ),
                            verticalSpacing(16.0),
                            AppElevatedButton(
                              onTap: () => fromFilled(),
                              child: const Icon(
                                proceedIcon,
                                size: 30,
                              ),
                            ),
                            verticalSpacing(42.0),
                            DualTextWidget(
                              question: "Have an account?",
                              todo: "Sign In",
                              onTap: () {
                                Navigator.pop(context);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
      ),
    );
  }
}
