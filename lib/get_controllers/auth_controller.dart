import 'package:get/get.dart';
import 'package:task_manager/utilities/utility_functions.dart';

class AuthController extends GetxController{
  bool loginInProgress = false;

  Future<bool> login(String email, String pass) async {
    loginInProgress = true;
    update();

    final result = await Utility.login(email, pass);
    loginInProgress = false;
    update();
    if (result) {
      return true;
    } else {
      return false;
    }
  }

}