import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/data_utilities.dart';
import '../utilities/get_x_dialog.dart';
import '../widgets/app_nav_bar.dart';
import '../widgets/application_bar.dart';
import '../widgets/screen_background.dart';
import 'task_components/canceled_task.dart';
import 'task_components/completed_task.dart';
import 'task_components/new_task.dart';
import 'task_components/progress_task.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int tabIndex = 0;
  onTapItem(int index) {
    setState(() {
      tabIndex = index;
    });
  }

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
                DataUtilities.moveToLoginPage();
              }
          );
        }
      ),
      body: ScreenBackground(
        child: widgetsOptions.elementAt(tabIndex),
      ),
      bottomNavigationBar: AppNavBar(
        currentIndex: tabIndex,
        onTap: (value) {
          onTapItem(value);
        },
      ),
    );
  }
}