import 'package:flutter/material.dart';
import 'package:task_manager/utilities/application_colors.dart';
import 'package:task_manager/utilities/text_styles.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:task_manager/widgets/task_app_bar.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {

  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: taskAppBar(fromHome: false),
      body: ScreenBackground(
        child: Column(
          children: [
            Text("Add new Task", style: authHeadline(colorDarkBlue),)
          ],
        ),
      ),
    );
  }
}
