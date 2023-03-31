import 'package:flutter/material.dart';

import '../../../data/data_utilities.dart';
import '../../../data/models/task_count_model.dart';
import '../../../data/models/task_model.dart';
import '../../../data/network_utils.dart';
import '../../../data/urls.dart';
import '../../utilities/get_x_bottom_sheet.dart';
import '../../utilities/get_x_dialog.dart';
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
  bool inProgress = true;
  bool countInProgress = true;

  TaskModel newTaskModel = TaskModel();
  TaskCountModel taskCountModel = TaskCountModel();

  int newTasks = 0;
  int progressingTask = 0;
  int completedTask = 0;
  int canceledTask = 0;

  @override
  void initState() {
    callData();
    getTaskCounts();
    super.initState();
  }

  callData() async {
    setState(() {inProgress = true;});

    var response = await NetworkUtils().getMethod(url: "${Urls.taskListURL}New");
    if (response["status"] == "success") {
      newTaskModel = TaskModel.fromJson(response);
    }

    setState(() {inProgress = false;});
  }

  Future<void> deleteItem(id) async {
    setState(() {
      inProgress = true;
      countInProgress = true;
    });

    DataUtilities.deleteItem(
      id,
      onSuccess: () {
        callData();
        getTaskCounts();
      }
    );
  }

  getTaskCounts() async {
    setState(() {countInProgress = true;});

    var response = await NetworkUtils().getMethod(url: Urls.taskCounterURL);

    if (response['status'] == "success") {
      taskCountModel = TaskCountModel.fromJson(response);
      var data = taskCountModel.data ?? [];

      for (var element in data) {
        switch (element.sId) {
          case "New": {
            newTasks = element.sum ?? 0;
            break;
          }
          case "Completed" : {
            completedTask = element.sum ?? 0;
            break;
          }
          case "Progress" : {
            progressingTask = element.sum ?? 0;
            break;
          }
          case "Canceled" : {
            canceledTask = element.sum ?? 0;
            break;
          }
        }
      }
    }

    setState(() {countInProgress = false;});
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          Container(
              child: countInProgress
                  ? UIUtility.processingGreen
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: DashboardItem(
                            numberOfTask: newTasks ,
                            type: 'New',
                        )),
                        Expanded(
                          child: DashboardItem(
                            numberOfTask: progressingTask,
                            type: 'Progress',
                        )),
                        Expanded(
                          child: DashboardItem(
                            numberOfTask: completedTask,
                            type: 'Completed',
                        )),
                        Expanded(
                          child: DashboardItem(
                            numberOfTask: canceledTask,
                            type: 'Canceled',
                        )),
                      ],
                    )),
          verticalSpacing(10.0),
          Expanded(
              child: inProgress
                  ? UIUtility.processingGreen
                  : RefreshIndicator(
                      onRefresh: () async {
                        callData();
                        getTaskCounts();
                      },
                      child: ListView.builder(
                          itemCount: newTaskModel.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            return TaskListItem(
                              title: newTaskModel.data?[index].title ?? "Unknown",
                              description: newTaskModel.data?[index].description ?? "Unknown",
                              date: newTaskModel.data?[index].createdDate ?? "Unknown",
                              type: newTaskModel.data?[index].status ?? "Unknown",
                              onEditTap: () {
                                getTaskUpdateBottomSheet(
                                    currentStatus: newTaskModel.data?[index].status ?? "Unknown",
                                    taskId: newTaskModel.data?[index].sId ?? "Unknown",
                                    onComplete: () {
                                      callData();
                                      getTaskCounts();
                                    }
                                );
                              },
                              onDeleteTap: () {
                                buildGetXDialog(
                                  title: "Delete",
                                  message: "Want to delete task: ${newTaskModel.data?[index].title ?? "Unknown"}",
                                  positiveButtonText: "No",
                                  positiveTap: () {
                                    Navigator.pop(context);
                                  },
                                  negativeButtonText: "Yes",
                                  negativeTap: () async {
                                    deleteItem(newTaskModel.data?[index].sId ?? "Unknown");
                                    Navigator.pop(context);
                                  }
                                );
                              },
                            );
                          }),
                    )),
        ],
      ),
    );
  }
}
