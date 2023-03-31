import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../data/data_utilities.dart';
import '../../data/network_utils.dart';
import '../../data/urls.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/toasts.dart';
import '../utilities/ui_utility.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/application_bar.dart';
import '../widgets/screen_background.dart';
import '../widgets/spacing.dart';

class AddNewTask extends StatefulWidget {
  const AddNewTask({Key? key}) : super(key: key);

  @override
  State<AddNewTask> createState() => _AddNewTaskState();
}

class _AddNewTaskState extends State<AddNewTask> {
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();

  final GlobalKey<FormState> _newTaskKey = GlobalKey<FormState>();

  bool inProgress = false;

  Future<void> checkAndAddTask() async {
    if (_newTaskKey.currentState!.validate()) {
      setState(() {
        inProgress = true;
      });
      final result = await NetworkUtils().postMethod(
        Urls.addTaskURL,
        body: {
          "title":title.text,
          "description":description.text,
          "status":"New"
        },
        onUnAuthorize: () {
          errorToast("Please login again");
          DataUtilities.moveToLoginPage();
        }
      );
      if (result != null && result["status"] == "success") {
        title.clear();
        description.clear();
        successToast("Task Added");
        Get.offAllNamed("/home");
      }
      setState(() {
        inProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: applicationBar(
        onProfileTap: () {
          Get.toNamed("/profile");
        }
      ),
      body: ScreenBackground(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Form(
              key: _newTaskKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Add new Task",
                    style: authHeadline(colorDarkBlue),
                  ),
                  verticalSpacing(24.0),
                  AppTextField(
                      validator: (value) {
                        if (value?.isEmpty ?? true) {
                          return "Enter task subject";
                        }
                        return null;
                      },
                      hint: "Subject",
                      controller: title
                  ),
                  verticalSpacing(16.0),
                  AppTextField(
                    validator: (value) {
                      if (value?.isEmpty ?? true) {
                        return "Enter a short description";
                      }
                      return null;
                    },
                    hint: "Description",
                    controller: description,
                    maxLine: 10,
                  ),
                  verticalSpacing(24.0),
                  AppElevatedButton(
                      onTap: () => checkAndAddTask(),
                      child: inProgress
                          ? UIUtility.processing
                          : UIUtility.proceedIcon
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
