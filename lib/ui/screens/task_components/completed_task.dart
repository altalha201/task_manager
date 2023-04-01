import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../get_controllers/completed_task_list_controller.dart';
import '../../get_controllers/taskDeleteController.dart';
import '../../utilities/get_x_bottom_sheet.dart';
import '../../utilities/ui_utility.dart';
import '../../widgets/task_list_item.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({Key? key}) : super(key: key);

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {

  @override
  void initState() {
    Get.find<CompletedTaskListController>().getCompletedTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CompletedTaskListController>(builder: (completedTaskController) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: completedTaskController.inProgress
            ? UIUtility.processingGreen
            : RefreshIndicator(
                onRefresh: () async {
                  completedTaskController.getCompletedTasks();
                },
                child: ListView.builder(
                    itemCount: completedTaskController.completedTaskModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskListItem(
                        title: completedTaskController.completedTaskModel.data?[index].title ?? "Unknown",
                        description: completedTaskController.completedTaskModel.data?[index].description ?? "Unknown",
                        date: completedTaskController.completedTaskModel.data?[index].createdDate ?? "Unknown",
                        type: completedTaskController.completedTaskModel.data?[index].status ?? "Unknown",
                        onEditTap: () {
                          getTaskUpdateBottomSheet(
                              currentStatus: completedTaskController.completedTaskModel.data?[index].status ?? "Unknown",
                              taskId: completedTaskController.completedTaskModel.data?[index].sId ?? "Unknown",
                              onComplete: () {
                                completedTaskController.getCompletedTasks();
                              }
                          );
                        },
                        onDeleteTap: () {
                          TaskDeleteController.deleteTask(
                              title: completedTaskController.completedTaskModel.data?[index].title ?? "Unknown",
                              id: completedTaskController.completedTaskModel.data?[index].sId ?? "Unknown",
                              onComplete: () {
                                completedTaskController.getCompletedTasks();
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
