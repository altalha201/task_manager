import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_manager/utilities/text_styles.dart';

import '../api/network_utils.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/spacing.dart';
import 'application_colors.dart';
import 'urls.dart';

Future<dynamic> taskChangeStatus(BuildContext context, {
  required String currentState,
  required String taskID,
  required VoidCallback onComplete
}) {

  String stateValue = currentState;

  return showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    builder: (context) {
      return StatefulBuilder(
          builder: (context, changeState) {
            return Container(
              decoration: const BoxDecoration(
                  color: colorWhite,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(25),
                    topRight: Radius.circular(25),
                  )
              ),
              child: Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  children: [
                    RadioListTile(
                        value: "New",
                        title: const Text("New"),
                        groupValue: stateValue,
                        onChanged: (state) {
                          changeState(() {
                            stateValue = state!;
                          });
                        }
                    ),
                    RadioListTile(
                        value: "Progress",
                        title: const Text("Progress"),
                        groupValue: stateValue,
                        onChanged: (state) {
                          changeState(() {
                            stateValue = state!;
                          });
                        }
                    ),
                    RadioListTile(
                        value: "Completed",
                        title: const Text("Completed"),
                        groupValue: stateValue,
                        onChanged: (state) {
                          changeState(() {
                            stateValue = state!;
                          });
                        }
                    ),
                    RadioListTile(
                        value: "Canceled",
                        title: const Text("Canceled"),
                        groupValue: stateValue,
                        onChanged: (state) {
                          changeState(() {
                            stateValue = state!;
                          });
                        }
                    ),
                    verticalSpacing(25.0),
                    AppElevatedButton(
                        onTap: () async {
                          final response = await NetworkUtils().getMethod(url: Urls.updateTaskUrl(taskID, stateValue));
                          if (response["status"] == "success") {
                            onComplete();
                          }
                          Get.back();
                        },
                        child: Text("Update", style: authButton(colorWhite),)
                    )
                  ],
                ),
              ),
            );
          }
      );
    },
  );
}