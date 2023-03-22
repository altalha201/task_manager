import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/screens/task_components/canceled_task.dart';
import 'package:task_manager/screens/task_components/completed_task.dart';
import 'package:task_manager/screens/task_components/new_task.dart';
import 'package:task_manager/screens/task_components/progress_task.dart';
import 'package:task_manager/utilities/utility_functions.dart';


import 'package:task_manager/widgets/app_nav_bar.dart';
import 'package:task_manager/widgets/screen_background.dart';

import '../utilities/dialog.dart';
import '../widgets/application_bar.dart';

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
        onLogOutTap: () async {
          await buildShowDialog(context,
          title: 'Logout!',
          message: "Want to logout?",
          positiveButtonText: 'No',
          negativeButtonText: 'Yes',
          positiveTap: () {
            Navigator.pop(context);
          },
          negativeTap: () {
            Utility.moveToLoginPage();
          },
          );
        }
      ),
      body: ScreenBackground(
        child: Expanded(child: widgetsOptions.elementAt(tabIndex)),
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
