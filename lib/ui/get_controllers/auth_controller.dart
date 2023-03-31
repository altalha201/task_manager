import 'package:get/get.dart';

import '../../data/data_utilities.dart';

class AuthController extends GetxController{
  bool loginInProgress = false;

  Future<bool> login(String email, String pass) async {
    loginInProgress = true;
    update();

    final result = await DataUtilities.login(email, pass);
    loginInProgress = false;
    update();
    if (result) {
      return true;
    } else {
      return false;
    }
  }
}