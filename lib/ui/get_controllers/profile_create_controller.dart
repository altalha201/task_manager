import 'package:get/get.dart';
import 'package:task_manager/data/data_utilities.dart';

import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utilities/toasts.dart';

class ProfileCreateController extends GetxController {
  bool inProgress = false;

  Future<bool> createProfile({
    required String email,
    required String mobile,
    required String firstName,
    required String lastName,
    required String password,
  }) async {
    inProgress = true;
    final result = await NetworkUtils().postMethod(Urls.registerURL, body: {
      "email": email,
      'mobile': mobile,
      'password': password,
      'firstName': firstName,
      'lastName': lastName,
    });
    inProgress = false;
    if (result != null && result['status'] == "success") {
      final login = await DataUtilities.login(email, password);
      if (login) {
        update();
        return true;
      } else {
        errorToast("Something went wrong while login. Try From Login later");
        update();
        return false;
      }
    } else {
      errorToast("Something went wrong try again");
      update();
      return false;
    }
  }
}
