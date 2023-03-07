import 'dart:developer';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:task_manager/utilities/toasts.dart';
import 'package:task_manager/utilities/urls.dart';

import '../api/api_client.dart';
import '../data/auth_utils.dart';
import 'application_colors.dart';

class Utility {

  static Icon proceedIcon = const Icon(
    Icons.arrow_circle_right_outlined,
    size: 30,
  );

  static Widget processing = const Center(
    child: CircularProgressIndicator(
      color: colorWhite,
    ),
  );

  static Widget processingGreen = const Center(
      child: CircularProgressIndicator(
        color: colorGreen,
      ),
    );

  static showBase64Image(base64String) {
    UriData? data = Uri.parse(base64String).data;
    Uint8List image = data!.contentAsBytes();
    return image;
  }

  static Future<bool> login(String email, String pass) async {

    final result = await NetworkUtils().postMethod(
        Urls.loginURL,
        body: {
          'email' : email,
          'password' : pass
        },
        onUnAuthorize: () {
          errorToast("Email or password is incorrect");
        }
    );
    if (result != null && result['status'] == 'success') {

      await AuthUtils.saveUserData(
          result['data']['firstName'],
          result['data']['lastName'],
          result['data']['photo'],
          result['data']['mobile'],
          result['data']['email'],
          result['token']
      );
      return true;
    }
    return false;
  }

}
