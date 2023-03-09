import 'package:flutter/material.dart';
import 'package:task_manager/api/network_utils.dart';
import 'package:task_manager/utilities/application_colors.dart';
import 'package:task_manager/utilities/text_styles.dart';
import 'package:task_manager/utilities/toasts.dart';
import 'package:task_manager/widgets/app_elevated_button.dart';
import 'package:task_manager/widgets/app_text_field.dart';
import 'package:task_manager/widgets/dual_text_widget.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:task_manager/widgets/spacing.dart';

class SetPasswordScreen extends StatefulWidget {
  final String email, otp;
  const SetPasswordScreen({Key? key, required this.email, required this.otp}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {

  final TextEditingController _newPasswordETController = TextEditingController();
  final TextEditingController _confirmPasswordETController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    const String subtitle = "Minimum length password 8 character with Letter and Number Combination";

    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Set Password", style: authHeadline(colorDarkBlue),),
                  verticalSpacing(8.0),
                  Text(subtitle, style: authSubtitle(colorLightGray),),
                  verticalSpacing(24.0),
                  AppTextField(hint: "Password",
                    validator: (value) {
                      if ((value?.isEmpty ?? true) &&
                          ((value?.length ?? 0) < 8)) {
                        return "Enter Password with 8 or more characters";
                      }
                      return null;
                    },
                    controller: _newPasswordETController, obscureText: true,),
                  verticalSpacing(16.0),
                  AppTextField(hint: "Confirm Password",
                    validator: (String? value) {
                      if ((value?.isEmpty ?? true) ||
                          ((value ?? '') != _newPasswordETController.text)) {
                        return 'Password mismatch';
                      }
                      return null;
                    },
                    controller: _confirmPasswordETController, obscureText: true,),
                  verticalSpacing(16.0),
                  AppElevatedButton(
                    onTap: () async {
                      if (_formKey.currentState!.validate()) {
                        var navigator = Navigator.of(context);
                        final response = await NetworkUtils().setPin(
                          {
                            "email":widget.email,
                            "OTP":widget.otp,
                            "password":_newPasswordETController.text
                          }
                        );
                        if(response) {
                          successToast("Password Reset");
                          navigator.pushNamedAndRemoveUntil("/login", (route) => false);
                        }
                        else {
                          errorToast("Something Went Wrong");
                        }
                      }
                    },
                    child: Text("Confirm", style: authButton(colorWhite),),
                  ),
                  verticalSpacing(42.0),
                  DualTextWidget(
                    question: "Have an account?",
                    todo: "Sign In",
                    onTap: () {
                      Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
