import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../get_controllers/canceled_task_list_controller.dart';
import '../../get_controllers/taskDeleteController.dart';
import '../../utilities/get_x_bottom_sheet.dart';
import '../../utilities/ui_utility.dart';
import '../../widgets/task_list_item.dart';

class CanceledTask extends StatefulWidget {
  const CanceledTask({Key? key}) : super(key: key);

  @override
  State<CanceledTask> createState() => _CanceledTaskState();
}

class _CanceledTaskState extends State<CanceledTask> {

  @override
  void initState() {
    Get.find<CanceledTaskListController>().getCanceledTasks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CanceledTaskListController>(builder: (canceledTaskListController) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
        child: canceledTaskListController.inProgress
            ? UIUtility.processingGreen
            : RefreshIndicator(
                onRefresh: () async {
                  canceledTaskListController.getCanceledTasks();
                },
                child: ListView.builder(
                    itemCount: canceledTaskListController.canceledTaskModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskListItem(
                        title: canceledTaskListController.canceledTaskModel.data?[index].title ?? "Unknown",
                        description: canceledTaskListController.canceledTaskModel.data?[index].description ?? "Unknown",
                        date: canceledTaskListController.canceledTaskModel.data?[index].createdDate ?? "Unknown",
                        type: canceledTaskListController.canceledTaskModel.data?[index].status ?? "Unknown",
                        onEditTap: () {
                          getTaskUpdateBottomSheet(
                              currentStatus: canceledTaskListController.canceledTaskModel.data?[index].status ?? "Unknown",
                              taskId: canceledTaskListController.canceledTaskModel.data?[index].sId ?? "Unknown",
                              onComplete: () {
                                canceledTaskListController.getCanceledTasks();
                              }
                          );
                        },
                        onDeleteTap: () {
                          TaskDeleteController.deleteTask(
                              title: canceledTaskListController.canceledTaskModel.data?[index].title ?? "Unknown",
                              id: canceledTaskListController.canceledTaskModel.data?[index].sId ?? "Unknown",
                              onComplete: () {
                                canceledTaskListController.getCanceledTasks();
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
