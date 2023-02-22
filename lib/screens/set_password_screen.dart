import 'package:flutter/material.dart';
import 'package:task_manager/utilities/application_colors.dart';
import 'package:task_manager/utilities/text_styles.dart';
import 'package:task_manager/widgets/app_elevated_button.dart';
import 'package:task_manager/widgets/app_text_field.dart';
import 'package:task_manager/widgets/dual_text_widget.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:task_manager/widgets/spacing.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  @override
  Widget build(BuildContext context) {

    const String subtitle = "Minimum length password 8 character with Letter and Number Combination";

    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Set Password", style: authHeadline(colorDarkBlue),),
                verticalSpacing(8.0),
                Text(subtitle, style: authSubtitle(colorLightGray),),
                verticalSpacing(24.0),
                AppTextField(hint: "Password", controller: TextEditingController(), obscureText: true,),
                verticalSpacing(16.0),
                AppTextField(hint: "Confirm Password", controller: TextEditingController(), obscureText: true,),
                verticalSpacing(16.0),
                AppElevatedButton(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(context, "/login", (route) => false);
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
    );
  }
}
