import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/class_controller/taskDeleteController.dart';
import '../../controllers/get_controllers/new_task_list_controller.dart';
import '../../controllers/get_controllers/task_count_controller.dart';
import '../../utilities/get_x_bottom_sheet.dart';
import '../../utilities/ui_utility.dart';
import '../../widgets/dashboard_item.dart';
import '../../widgets/spacing.dart';
import '../../widgets/task_list_item.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {

  @override
  void initState() {
    Get.find<NewTaskListController>().getAllNewTask();
    Get.find<TaskCountController>().getTaskCounts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          GetBuilder<TaskCountController>(builder: (taskCountController) {
            return Container(
                child: taskCountController.inProgress
                    ? UIUtility.processingGreen
                    : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: DashboardItem(
                        numberOfTask: taskCountController.newTasks ,
                        type: 'New',
                      )),
                    Expanded(
                      child: DashboardItem(
                        numberOfTask: taskCountController.progressingTask,
                        type: 'Progress',
                      )),
                    Expanded(
                      child: DashboardItem(
                        numberOfTask: taskCountController.completedTask,
                        type: 'Completed',
                      )),
                    Expanded(
                      child: DashboardItem(
                        numberOfTask: taskCountController.canceledTask,
                        type: 'Canceled',
                      )),
                  ],
                )
            );
          }),
          verticalSpacing(10.0),
          GetBuilder<NewTaskListController>(builder: (newTaskController) {
            return Expanded(
                child: newTaskController.inProgress
                    ? UIUtility.processingGreen
                    : RefreshIndicator(
                  onRefresh: () async {
                    newTaskController.getAllNewTask();
                    Get.find<TaskCountController>().getTaskCounts();
                  },
                  child: ListView.builder(
                    itemCount: newTaskController.newTaskModel.data?.length ?? 0,
                    itemBuilder: (context, index) {
                      return TaskListItem(
                        title: newTaskController.newTaskModel.data?[index].title ?? "Unknown",
                        description: newTaskController.newTaskModel.data?[index].description ?? "Unknown",
                        date: newTaskController.newTaskModel.data?[index].createdDate ?? "Unknown",
                        type: newTaskController.newTaskModel.data?[index].status ?? "Unknown",
                        onEditTap: () {
                          getTaskUpdateBottomSheet(
                              currentStatus: newTaskController.newTaskModel.data?[index].status ?? "Unknown",
                              taskId: newTaskController.newTaskModel.data?[index].sId ?? "Unknown",
                              onComplete: () {
                                newTaskController.getAllNewTask();
                                Get.find<TaskCountController>().getTaskCounts();
                              }
                          );
                        },
                        onDeleteTap: () {
                          TaskDeleteController.deleteTask(
                              title: newTaskController.newTaskModel.data?[index].title ?? "Unknown",
                              id: newTaskController.newTaskModel.data?[index].sId ?? "Unknown",
                              onComplete: () {
                                newTaskController.getAllNewTask();
                                Get.find<TaskCountController>().getTaskCounts();
                              }
                          );
                        },
                      );
                    }),
                ));
          }),
        ],
      ),
    );
  }
}
