import '../../../data/auth_utils.dart';

class SplashController {
  static Future<bool> checkUserState() async {
    final bool userState = await AuthUtils.checkLoginState();
    if (userState) {
      await AuthUtils.getAuthData();
      return true;
    }
    else {
      return false;
    }
  }
}