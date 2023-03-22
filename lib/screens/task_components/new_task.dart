import 'package:flutter/material.dart';
import 'package:task_manager/utilities/urls.dart';
import 'package:task_manager/widgets/spacing.dart';

import '../../api/network_utils.dart';

import '../../utilities/bottom_sheet.dart';
import '../../utilities/dialog.dart';
import '../../utilities/utility_functions.dart';
import '../../widgets/dashboard_item.dart';
import '../../widgets/task_list_item.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool inProgress = true;
  bool countInProgress = true;

  int newTasks = 0;
  int progressingTask = 0;
  int completedTask = 0;
  int canceledTask = 0;

  List taskItems = [];

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
      var data = response["data"];
      taskItems = data;
    }

    setState(() {inProgress = false;});
  }

  Future<void> deleteItem(id) async {
    setState(() {
      inProgress = true;
      countInProgress = true;
    });

    Utility.deleteItem(
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
      var data = response['data'];
      newTasks = 0; completedTask = 0; progressingTask = 0; canceledTask = 0;

      for (var element in data) {
        switch (element["_id"]) {
          case "New": {
            newTasks = element["sum"];
            break;
          }
          case "Completed" : {
            completedTask = element["sum"];
            break;
          }
          case "Progress" : {
            progressingTask = element["sum"];
            break;
          }
          case "Canceled" : {
            canceledTask = element["sum"];
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
                  ? Utility.processingGreen
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
                  ? Utility.processingGreen
                  : RefreshIndicator(
                      onRefresh: () async {
                        callData();
                        getTaskCounts();
                      },
                      child: ListView.builder(
                          itemCount: taskItems.length,
                          itemBuilder: (context, index) {
                            return TaskListItem(
                              title: taskItems[index]['title'],
                              description: taskItems[index]['description'],
                              date: taskItems[index]['createdDate'],
                              type: taskItems[index]['status'],
                              onEditTap: () {
                                taskChangeStatus(
                                  context,
                                  currentState: taskItems[index]['status'],
                                  taskID: taskItems[index]['_id'],
                                  onComplete: () {
                                    callData();
                                    getTaskCounts();
                                  }
                                );
                              },
                              onDeleteTap: () {
                                buildShowDialog(
                                  context,
                                  title: "Delete",
                                  message: "Want to delete task: ${taskItems[index]['title']}",
                                  positiveButtonText: "No",
                                  positiveTap: () {
                                    Navigator.pop(context);
                                  },
                                  negativeButtonText: "Yes",
                                  negativeTap: () async {
                                    deleteItem(taskItems[index]["_id"]);
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
