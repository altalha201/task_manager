import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controllers/auth_controller.dart';
import '../controllers/get_controllers/home_controller.dart';
import '../utilities/get_x_dialog.dart';
import '../widgets/app_nav_bar.dart';
import '../widgets/application_bar.dart';
import '../widgets/screen_background.dart';
import 'task_components/canceled_task.dart';
import 'task_components/completed_task.dart';
import 'task_components/new_task.dart';
import 'task_components/progress_task.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);

  final widgetsOptions = [
    const NewTask(),
    const ProgressTask(),
    const CompletedTask(),
    const CanceledTask(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: applicationBar(
        fromHome: true,
        onProfileTap: () {
          Get.toNamed("/profile");
        },
        onAddTap: () {
          Get.toNamed("/addTask");
        },
        onLogOutTap: () {
          buildGetXDialog(
              title: 'Logout!',
              message: "Want to logout?",
              positiveButtonText: 'No',
              negativeButtonText: 'Yes',
              positiveTap: () {
                Get.back();
              },
              negativeTap: () {
                Get.find<AuthController>().logout();
              }
          );
        }
      ),
      body: ScreenBackground(
        child: GetBuilder<HomeController>(builder: (homeController) {
          return widgetsOptions.elementAt(homeController.currentIndex);
        },),
      ),
      bottomNavigationBar: AppNavBar(
        currentIndex: Get.find<HomeController>().currentIndex,
        onTap: (value) {
          Get.find<HomeController>().changeIndex(value);
        },
      ),
    );
  }
}
