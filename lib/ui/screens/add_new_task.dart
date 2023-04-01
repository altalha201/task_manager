import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controllers/add_new_task_controller.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/toasts.dart';
import '../utilities/ui_utility.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/app_text_field.dart';
import '../widgets/application_bar.dart';
import '../widgets/screen_background.dart';
import '../widgets/spacing.dart';

class AddNewTask extends StatelessWidget {
  AddNewTask({Key? key}) : super(key: key);

  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  final GlobalKey<FormState> _newTaskKey = GlobalKey<FormState>();

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
                  GetBuilder<AddNewTaskController>(builder: (addNewTaskController) {
                    return AppElevatedButton(
                        onTap: () async {
                          if (_newTaskKey.currentState!.validate()) {
                            var result = await addNewTaskController.addTask(
                              title: title.text, 
                              description: description.text
                            );
                            if (result) {
                              successToast("Task Added Successful");
                              Get.offAllNamed("/home");
                            }
                          }
                        },
                        child: addNewTaskController.inProgress
                            ? UIUtility.processing
                            : UIUtility.proceedIcon
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
