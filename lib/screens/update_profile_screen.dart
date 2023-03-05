import 'package:flutter/material.dart';
import 'package:task_manager/utilities/utility_functions.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:task_manager/widgets/task_app_bar.dart';

import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/dual_text_widget.dart';
import '../widgets/spacing.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: taskAppBar(context: context, fromHome: false),
      body: ScreenBackground(
        child: SingleChildScrollView(
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
                    "Update Profile",
                    style: authHeadline(colorDarkBlue),
                  ),
                  verticalSpacing(24.0),

                  InkWell(
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: const BoxDecoration(
                            color: colorDarkBlue,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(8),
                              bottomLeft: Radius.circular(8),
                            ),
                          ),
                          child: const Text("Photo", style: TextStyle(color: colorWhite),),
                        ),
                        Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: const BoxDecoration(
                                color: colorWhite,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(8),
                                  bottomRight: Radius.circular(8),
                                ),
                              ),
                              child: const Text(
                                "",
                                maxLines: 1,
                                style: TextStyle(overflow: TextOverflow.ellipsis),
                              ),
                            ),
                        )
                      ],
                    ),
                  ),

                  verticalSpacing(16.0),
                  AppTextField(
                    hint: "Email",
                    controller: emailController,
                    readOnly: true,
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
                    onTap: () {},
                    child: Utility.proceedIcon
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
        ),
      ),
    );
  }
}
