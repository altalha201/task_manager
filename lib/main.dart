import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'ui/controllers/get_controllers/account_recovery_controller.dart';
import 'ui/controllers/get_controllers/add_new_task_controller.dart';
import 'ui/controllers/get_controllers/auth_controller.dart';
import 'ui/controllers/get_controllers/canceled_task_list_controller.dart';
import 'ui/controllers/get_controllers/completed_task_list_controller.dart';
import 'ui/controllers/get_controllers/home_controller.dart';
import 'ui/controllers/get_controllers/new_task_list_controller.dart';
import 'ui/controllers/get_controllers/profile_create_controller.dart';
import 'ui/controllers/get_controllers/profile_update_controller.dart';
import 'ui/controllers/get_controllers/progress_task_list_controller.dart';
import 'ui/controllers/get_controllers/task_count_controller.dart';
import 'ui/controllers/get_controllers/update_status_controller.dart';
import 'ui/screens/add_new_task.dart';
import 'ui/screens/email_verification_screen.dart';
import 'ui/screens/home_screen.dart';
import 'ui/screens/login_screen.dart';
import 'ui/screens/pin_verification_screen.dart';
import 'ui/screens/set_password_screen.dart';
import 'ui/screens/sign_up_screen.dart';
import 'ui/screens/splash_screen.dart';
import 'ui/screens/update_profile_screen.dart';
import 'ui/utilities/application_colors.dart';


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
        GetPage(name: '/emailVerification', page: () => EmailVerificationScreen()),
        GetPage(name: '/pinVerification', page: () => PinVerificationScreen()),
        GetPage(name: '/setPass', page: () => SetPasswordScreen()),
        GetPage(name: '/signUp', page: () => SignUpScreen()),
        GetPage(name: '/home', page: () => HomeScreen()),
        GetPage(name: '/addTask', page: () => AddNewTask()),
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
    Get.put(NewTaskListController());
    Get.put(TaskCountController());
    Get.put(ProgressTaskListController());
    Get.put(CompletedTaskListController());
    Get.put(CanceledTaskListController());
    Get.put(AddNewTaskController());
    Get.put(ProfileCreateController());
    Get.put(AccountRecoveryController());
    Get.put(ProfileUpdateController());
    Get.put(HomeController());
  }
}
