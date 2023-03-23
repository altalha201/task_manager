import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/api/network_utils.dart';
import 'package:task_manager/utilities/toasts.dart';
import 'package:task_manager/utilities/urls.dart';
import 'package:task_manager/utilities/utility_functions.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:image_picker/image_picker.dart';

import '../data/auth_utils.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/application_bar.dart';
import '../widgets/spacing.dart';

class UpdateProfileScreen extends StatefulWidget {
  const UpdateProfileScreen({Key? key}) : super(key: key);

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {

  final emailController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();

  XFile? pickedImage;
  String? base64Image;

  bool inProgress = false;

  @override
  initState() {
    super.initState();
    emailController.text = AuthUtils.email ?? "";
    firstNameController.text = AuthUtils.firstName ?? "";
    lastNameController.text = AuthUtils.lastName ?? "";
    phoneController.text = AuthUtils.mobile ?? "";
  }

  Future<void> pickImage() async {
    Get.defaultDialog(
      title: "Pick Image Form",
      textCancel: "Cancel",
      cancelTextColor: colorRed,
      buttonColor: colorRed,
      content: Column(
        children: [
          ListTile(
            onTap: () async {
              var navigator = Navigator.of(context);
              pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
              if (pickedImage != null) {
                setState(() {});
              }
              navigator.pop();
            },
            leading: const Icon(Icons.camera_alt_outlined, size: 34, color: colorDarkBlue,),
            title: const Text("Camera"),
          ),
          ListTile(
            onTap: () async {
              var navigator = Navigator.of(context);
              pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedImage != null) {
                setState(() {});
              }
              navigator.pop();
            },
            leading: const Icon(Icons.image_outlined, size: 34, color: colorDarkBlue,),
            title: const Text("Gallery"),
          )
        ],
      ),
    );
  }

  Future<void> updateProfile() async {

    setState(() {
      inProgress = true;
    });

    Map<String, String> requestBody = {
      'firstName':firstNameController.text,
      'lastName':lastNameController.text,
      'mobile':phoneController.text.trim(),
    };

    if (pickedImage != null) {
      List<int> imageBytes = await pickedImage!.readAsBytes();
      base64Image = base64Encode(imageBytes);
      requestBody['photo'] = base64Image ?? "";
      setState(() {
        AuthUtils.profilePic = base64Image ?? AuthUtils.profilePic;
      });
    }

    if (passwordController.text.isNotEmpty) {
      requestBody['password'] = passwordController.text;
    }

    final response = await NetworkUtils().postMethod(
      Urls.profileUpdateURL,
      body: requestBody
    );
    if (response != null && response['status'] == "success") {
      successToast("Profile update");
      setState(() {
        AuthUtils.firstName = firstNameController.text;
        AuthUtils.lastName = lastNameController.text;
        AuthUtils.mobile = phoneController.text.trim();
      });
      Get.offAllNamed("/home");
    }

    setState(() {
      inProgress = false;
    });
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
                  onTap: () => pickImage(),
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
                            child: Text(
                              pickedImage?.name ?? "",
                              maxLines: 1,
                              style: const TextStyle(overflow: TextOverflow.ellipsis),
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
                verticalSpacing(24.0),
                AppElevatedButton(
                  onTap: () {
                    updateProfile();
                  },
                  child: inProgress
                      ? Utility.processing
                      : Text("Update", style: authButton(colorWhite),)
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
