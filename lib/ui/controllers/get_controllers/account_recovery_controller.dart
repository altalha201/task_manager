import 'package:get/get.dart';

import '../../../data/network_utils.dart';
import '../../../data/urls.dart';

class AccountRecoveryController extends GetxController {

  String storedEmail = "";
  String storedOTP = "";

  Future<bool> sendEmail({required String email}) async {
    final result = await NetworkUtils().getMethod(url: Urls.recoveryEmail(email));
    if (result != null && result['status'] == "success") {
      storedEmail = email;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkOTP({required String pin}) async {
    final result = await NetworkUtils().getMethod(url: Urls.otpURL(storedEmail, pin));
    if (result != null && result['status'] == "success") {
      storedOTP = pin;
      return true;
    } else {
      return false;
    }
  }

  Future<bool> resetPassword({required String pass}) async {
    final result = await NetworkUtils().postMethod(
      Urls.recoverPassURL,
      body: {
        "email" : storedEmail,
        "OTP" : storedOTP,
        "password" : pass
      }
    );
    if (result != null && result['status'] == "success") {
      storedEmail = ""; storedOTP = "";
      return true;
    } else {
      return false;
    }
  }

}