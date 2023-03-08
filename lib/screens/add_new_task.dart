import 'package:flutter/material.dart';
import 'package:task_manager/utilities/application_colors.dart';
import 'package:task_manager/utilities/text_styles.dart';
import 'package:task_manager/widgets/app_elevated_button.dart';
import 'package:task_manager/widgets/app_text_field.dart';
import 'package:task_manager/widgets/screen_background.dart';
import 'package:task_manager/widgets/spacing.dart';
import 'package:task_manager/widgets/profile_bar.dart';

import '../api/api_client.dart';
import '../data/auth_utils.dart';
import '../utilities/toasts.dart';
import '../utilities/urls.dart';
import '../utilities/utility_functions.dart';

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
      final navigator = Navigator.of(context);
      final result = await NetworkUtils().postMethod(
        Urls.addTaskURL,
        body: {
          "title":title.text,
          "description":description.text,
          "status":"New"
        },
        onUnAuthorize: () {
          errorToast("Please login again");
          AuthUtils.clearData();
          navigator.pushNamedAndRemoveUntil("/login", (route) => false);
        }
      );
      if (result != null && result["status"] == "success") {
        title.clear();
        description.clear();
        successToast("Task Added");
        navigator.pushNamedAndRemoveUntil("/home", (route) => false);
      }
      setState(() {
        inProgress = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScreenBackground(
        child: SafeArea(
          child: Column(
            children: [
              ProfileBar(
                onProfileTap: () {
                  Navigator.pushNamed(context, "/profile");
                },
              ),
              Expanded(
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
                                  ? Utility.processing
                                  : Utility.proceedIcon
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
