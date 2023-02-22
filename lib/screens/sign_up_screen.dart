import 'package:flutter/material.dart';
import 'package:task_manager/utilities/application_colors.dart';
import 'package:task_manager/utilities/text_styles.dart';
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
  var emailController = TextEditingController();
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var phoneController = TextEditingController();
  var passwordController = TextEditingController();

  var loading = false;

  void fromFilled() {}

  @override
  Widget build(BuildContext context) {
    const proceedIcon = Icons.arrow_circle_right_outlined;

    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
            child: loading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      padding: const EdgeInsets.all(24.0),
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
                              hint: "Email", controller: emailController),
                          verticalSpacing(16.0),
                          AppTextField(
                              hint: "First Name",
                              controller: firstNameController),
                          verticalSpacing(16.0),
                          AppTextField(
                              hint: "Last Name",
                              controller: lastNameController),
                          verticalSpacing(16.0),
                          AppTextField(
                            hint: "Mobile Number",
                            controller: phoneController,
                            inputType: TextInputType.phone,
                          ),
                          verticalSpacing(16.0),
                          AppTextField(
                            hint: "Password",
                            controller: passwordController,
                            obscureText: true,
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
                  )),
      ),
    );
  }
}
