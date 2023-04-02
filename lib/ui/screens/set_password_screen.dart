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

class SetPasswordScreen extends StatelessWidget {
  SetPasswordScreen({Key? key}) : super(key: key);

  final TextEditingController _newPasswordETController = TextEditingController();
  final TextEditingController _confirmPasswordETController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                  Text(UIUtility.subtitlePass, style: authSubtitle(colorLightGray),),
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
                        if(await Get.find<AccountRecoveryController>().resetPassword(pass: _newPasswordETController.text)) {
                          successToast("Password Reset");
                          Get.offAllNamed("/login");
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
                      Get.offAllNamed("/login");
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
