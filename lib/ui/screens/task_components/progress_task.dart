import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/class_controller/taskDeleteController.dart';
import '../../controllers/get_controllers/progress_task_list_controller.dart';
import '../../utilities/get_x_bottom_sheet.dart';
import '../../utilities/ui_utility.dart';
import '../../widgets/task_list_item.dart';

class ProgressTask extends StatefulWidget {
  const ProgressTask({Key? key}) : super(key: key);

  @override
  State<ProgressTask> createState() => _ProgressTaskState();
}

class _ProgressTaskState extends State<ProgressTask> {

  @override
  void initState() {
    Get.find<ProgressTaskListController>().getProgressTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProgressTaskListController>(builder: (progressTaskController) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: progressTaskController.inProgress
            ? UIUtility.processingGreen
            : RefreshIndicator(
                onRefresh: () async {
                  progressTaskController.getProgressTasks();
                },
                child: ListView.builder(
                  itemCount: progressTaskController.progressTaskModel.data?.length ?? 0,
                  itemBuilder: (context, index) {
                    return TaskListItem(
                      title: progressTaskController.progressTaskModel.data?[index].title ?? "Unknown",
                      description: progressTaskController.progressTaskModel.data?[index].description ?? "Unknown",
                      date: progressTaskController.progressTaskModel.data?[index].createdDate ?? "Unknown",
                      type: progressTaskController.progressTaskModel.data?[index].status ?? "Unknown",
                      onEditTap: () {
                        getTaskUpdateBottomSheet(
                            currentStatus: progressTaskController.progressTaskModel.data?[index].status ?? "Unknown",
                            taskId: progressTaskController.progressTaskModel.data?[index].sId ?? "",
                            onComplete: () {
                              progressTaskController.getProgressTasks();
                            }
                        );
                      },
                      onDeleteTap: () {
                        TaskDeleteController.deleteTask(
                          title: progressTaskController.progressTaskModel.data?[index].title ?? "Unknown",
                          id: progressTaskController.progressTaskModel.data?[index].sId ?? "Unknown",
                          onComplete: () {
                            progressTaskController.getProgressTasks();
                          }
                        );
                      },
                    );
                  }),
        ),
      );
    });
  }
}
