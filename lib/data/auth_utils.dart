import 'package:shared_preferences/shared_preferences.dart';

class AuthUtils {
  static String? firstName, lastName, token, profilePic, mobile, email;

  static Future<void> saveUserData(
      String uFirstName, String uLastName, String uProfile, String uPhone, String uMail, String uToken
      ) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.setString('token', uToken);
    await sharedPreferences.setString('firstName', uFirstName);
    await sharedPreferences.setString('lastName', uLastName);
    await sharedPreferences.setString('phone', uPhone);
    await sharedPreferences.setString('profile', uProfile);
    await sharedPreferences.setString('email', uMail);

    firstName = uFirstName;
    lastName = uLastName;
    token = uToken;
    profilePic = uProfile;
    email = uMail;
    mobile = uPhone;
  }

  static Future<bool> checkLoginState() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    String? token = sharedPreferences.getString('token');
    if (token == null) {
      return false;
    } else {
      return true;
    }
  }

  static Future<void> getAuthData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    token = sharedPreferences.getString('token');
    firstName = sharedPreferences.getString('firstName');
    lastName = sharedPreferences.getString('lastName');
    profilePic = sharedPreferences.getString('profile');
    mobile = sharedPreferences.getString('phone');
    email = sharedPreferences.getString('email');
  }

  static Future<void> clearData() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    await sharedPreferences.clear();
  }

}