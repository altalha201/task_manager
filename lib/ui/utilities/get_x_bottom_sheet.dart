import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/get_controllers/update_status_controller.dart';
import '../widgets/app_elevated_button.dart';
import '../widgets/spacing.dart';
import 'application_colors.dart';
import 'text_styles.dart';
import 'toasts.dart';

void getTaskUpdateBottomSheet({
  required String currentStatus,
  required String taskId,
  required VoidCallback onComplete,
}) {
  Get.find<UpdateStatusController>().updateStatus(currentStatus);

  Get.bottomSheet(
    Container(
      decoration: const BoxDecoration(
        color: colorWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(25),
        child: Column(
          children: [
            GetBuilder<UpdateStatusController>(
                builder: (updateStatusController) {
              return RadioListTile(
                  value: "New",
                  title: const Text("New"),
                  groupValue: updateStatusController.status,
                  onChanged: (status) {
                    updateStatusController.updateStatus(status);
                  });
            }),
            GetBuilder<UpdateStatusController>(
                builder: (updateStatusController) {
              return RadioListTile(
                  value: "Progress",
                  title: const Text("Progress"),
                  groupValue: updateStatusController.status,
                  onChanged: (status) {
                    updateStatusController.updateStatus(status);
                  });
            }),
            GetBuilder<UpdateStatusController>(
                builder: (updateStatusController) {
              return RadioListTile(
                  value: "Completed",
                  title: const Text("Completed"),
                  groupValue: updateStatusController.status,
                  onChanged: (status) {
                    updateStatusController.updateStatus(status);
                  });
            }),
            GetBuilder<UpdateStatusController>(
                builder: (updateStatusController) {
              return RadioListTile(
                  value: "Canceled",
                  title: const Text("Canceled"),
                  groupValue: updateStatusController.status,
                  onChanged: (status) {
                    updateStatusController.updateStatus(status);
                  });
            }),
            verticalSpacing(25.0),
            AppElevatedButton(
                onTap: () async {
                  final result = await Get.find<UpdateStatusController>()
                      .updateToAPI(taskId);
                  if (result) {
                    onComplete();
                  } else {
                    errorToast("Update Failed!");
                  }
                  Get.back();
                },
                child: Text(
                  "Update",
                  style: authButton(colorWhite),
                )),
          ],
        ),
      ),
    ),
    backgroundColor: Colors.transparent,
  );
}
