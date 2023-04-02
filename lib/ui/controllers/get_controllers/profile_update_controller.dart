import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../data/auth_utils.dart';
import '../../../data/network_utils.dart';
import '../../../data/urls.dart';
import '../../utilities/application_colors.dart';

class ProfileUpdateController extends GetxController {
  bool inProgress = false;
  XFile? pickedImage;
  String? base64Image;

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
              pickedImage = await ImagePicker().pickImage(source: ImageSource.camera);
              if (pickedImage != null) {
                update();
              }
              Get.back();
            },
            leading: const Icon(Icons.camera_alt_outlined, size: 34, color: colorDarkBlue,),
            title: const Text("Camera"),
          ),
          ListTile(
            onTap: () async {
              pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
              if (pickedImage != null) {
                update();
              }
              Get.back();
            },
            leading: const Icon(Icons.image_outlined, size: 34, color: colorDarkBlue,),
            title: const Text("Gallery"),
          )
        ],
      ),
    );
  }

  Future<bool> updateProfile({
    required Map<String, String> requestBody
  }) async {
    inProgress = true;
    update();

    if (pickedImage != null) {
      List<int> imageBytes = await pickedImage!.readAsBytes();
      base64Image = base64Encode(imageBytes);
      requestBody['photo'] = base64Image ?? "";
      AuthUtils.profilePic = base64Image ?? AuthUtils.profilePic;
    }

    final response = await NetworkUtils().postMethod(
      Urls.profileUpdateURL,
      body: requestBody
    );
    inProgress = false;
    if (response != null && response['status'] == "success") {
      AuthUtils.firstName = requestBody["firstName"];
      AuthUtils.lastName = requestBody["lastName"];
      AuthUtils.mobile = requestBody["mobile"];
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}