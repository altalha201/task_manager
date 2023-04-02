import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/auth_utils.dart';
import '../controllers/get_controllers/profile_update_controller.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/toasts.dart';
import '../utilities/ui_utility.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/application_bar.dart';
import '../widgets/screen_background.dart';
import '../widgets/spacing.dart';


class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final emailET = TextEditingController();
  final firstNameET = TextEditingController();
  final lastNameET = TextEditingController();
  final mobileET = TextEditingController();
  final passET = TextEditingController();

  @override
  initState() {
    super.initState();
    emailET.text = AuthUtils.email ?? "";
    firstNameET.text = AuthUtils.firstName ?? "";
    lastNameET.text = AuthUtils.lastName ?? "";
    mobileET.text = AuthUtils.mobile ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: applicationBar(),
      body: ScreenBackground(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Update Profile",
                  style: authHeadline(colorDarkBlue),
                ),
                verticalSpacing(24.0),
                InkWell(
                  onTap: () {
                    Get.find<ProfileUpdateController>().pickImage();
                  },
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
                            child: GetBuilder<ProfileUpdateController>(builder: (updateController) {
                              return Text(
                                updateController.pickedImage?.name ?? "",
                                maxLines: 1,
                                style: const TextStyle(overflow: TextOverflow.ellipsis),
                              );
                            }),
                          ),
                      )
                    ],
                  ),
                ),

                verticalSpacing(16.0),
                AppTextField(
                  hint: "Email",
                  controller: emailET,
                  readOnly: true,
                ),
                verticalSpacing(16.0),
                AppTextField(
                  hint: "First Name",
                  controller: firstNameET,
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
                  controller: lastNameET,
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
                  controller: mobileET,
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
                  controller: passET,
                  obscureText: true,
                  validator: (value) {
                    if ((value?.isEmpty ?? true) &&
                        ((value?.length ?? 0) < 8)){
                      return "Enter Password with 8 or more characters";
                    }
                    return null;
                  },
                ),
                verticalSpacing(24.0),
                GetBuilder<ProfileUpdateController>(builder: (updateController) {
                  return AppElevatedButton(
                      onTap: () async {
                        Map<String, String> requestBody = {
                          "firstName" : firstNameET.text,
                          "lastName" : lastNameET.text,
                          "mobile" : mobileET.text.trim()
                        };

                        if (passET.text.isNotEmpty) {
                          requestBody["password"] = passET.text;
                        }

                        if (await Get.find<ProfileUpdateController>().updateProfile(requestBody: requestBody)) {
                          successToast("Profile updated");
                          Get.offAllNamed("/");
                        } else {
                          errorToast("Update failed");
                        }
                      },
                      child: updateController.inProgress
                          ? UIUtility.processing
                          : Text("Update", style: authButton(colorWhite),)
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
