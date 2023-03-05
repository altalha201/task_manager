import 'package:flutter/material.dart';
import 'package:task_manager/utilities/application_colors.dart';
import 'package:task_manager/utilities/text_styles.dart';
import 'package:task_manager/widgets/app_elevated_button.dart';
import 'package:task_manager/widgets/app_text_field.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:task_manager/widgets/spacing.dart';
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
      appBar: taskAppBar(fromHome: false, context: context),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Add new Task", style: authHeadline(colorDarkBlue),),
                  verticalSpacing(24.0),
                  AppTextField(hint: "Subject", controller: TextEditingController()),
                  verticalSpacing(8.0),
                  AppTextField(hint: "Description", controller: TextEditingController(), maxLine: 10,),
                  verticalSpacing(16.0),
                  AppElevatedButton(onTap: () {  }, child: const Icon(Icons.arrow_circle_right_outlined, size: 30,))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
