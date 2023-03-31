import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../ui/utilities/toasts.dart';
import 'auth_utils.dart';
import 'network_utils.dart';
import 'urls.dart';

class DataUtilities {

  static Future<void> moveToLoginPage() async {
    await AuthUtils.clearData();
    Get.offAllNamed("/login");
  }


  static Future<void> deleteItem(String id, {VoidCallback? onSuccess}) async {
    var response = await NetworkUtils().getMethod(url: Urls.deleteTaskURL(id));

    if (response['status'] == "success") {
      onSuccess!();
      successToast("Task Delete Success");
    } else {
      errorToast("Task delete failed!");
    }
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