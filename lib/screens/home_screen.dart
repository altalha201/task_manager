import 'package:flutter/material.dart';
import 'package:task_manager/screens/task_components/canceled_task.dart';
import 'package:task_manager/screens/task_components/completed_task.dart';
import 'package:task_manager/screens/task_components/new_task.dart';
import 'package:task_manager/screens/task_components/progress_task.dart';

import 'package:task_manager/widgets/app_nav_bar.dart';
import 'package:task_manager/widgets/profile_bar.dart';
import 'package:task_manager/widgets/screen_background.dart';

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
/*      appBar: taskAppBar(
        onAddTap: () {
          Navigator.pushNamed(context, '/addTask');
        },
        onLogOutTap: () {  },
        fromHome: true, context: context
      ),*/
      body: ScreenBackground(
        child: SafeArea(
          child: Column(
            children: [
              ProfileBar(
                fromHome: true,
                onProfileTap: () {
                  Navigator.pushNamed(context, "/profile");
                },
                onAddTap: () {
                  Navigator.pushNamed(context, '/addTask');
                },
              ),
              Expanded(child: widgetsOptions.elementAt(tabIndex))
            ],
          ),
        ),
      ),
      bottomNavigationBar: AppNavBar(
        currentIndex: tabIndex,
        onTap: (value) {
          onTapItem(value);
        },)
      ,
    );
  }
}
