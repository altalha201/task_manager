import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/get_controllers/auth_controller.dart';
import 'package:task_manager/get_controllers/update_status_controller.dart';
import 'package:task_manager/screens/add_new_task.dart';
import 'package:task_manager/screens/email_verification_screen.dart';
import 'package:task_manager/screens/home_screen.dart';
import 'package:task_manager/screens/pin_verification_screen.dart';
import 'package:task_manager/screens/set_password_screen.dart';
import 'package:task_manager/screens/sign_up_screen.dart';
import 'package:task_manager/screens/splash_screen.dart';
import 'package:task_manager/screens/update_profile_screen.dart';
import 'package:task_manager/utilities/application_colors.dart';

import 'screens/login_screen.dart';

void main() {
  runApp(const TaskManagerApp());
}

class TaskManagerApp extends StatelessWidget {
  const TaskManagerApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Manager',
      theme: ThemeData(
        primaryColor: colorGreen
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      initialBinding: StoreBinding(),
      getPages: [
        GetPage(name: '/', page: () => const SplashScreen()),
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/emailVerification', page: () => const EmailVerificationScreen()),
        GetPage(name: '/pinVerification', page: () => const PinVerificationScreen()),
        GetPage(name: '/setPass', page: () => const SetPasswordScreen()),
        GetPage(name: '/signUp', page: () => const SignUpScreen()),
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/addTask', page: () => const AddNewTask()),
        GetPage(name: '/profile', page: () => const UpdateProfileScreen()),
      ],
    );
  }
}

class StoreBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(UpdateStatusController());
    Get.put(AuthController());
  }

}
