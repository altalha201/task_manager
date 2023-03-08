import 'package:flutter/material.dart';
import 'package:task_manager/widgets/spacing.dart';

import '../../api/api_client.dart';

import '../../utilities/utility_functions.dart';
import '../../widgets/dashboard_item.dart';
import '../../widgets/task_list_view.dart';

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
  List counts = [];

  @override
  void initState() {
    callData();
    getTaskCounts();
    super.initState();
  }

  callData() async {
    setState(() {
      inProgress = true;
    });
    var data = await NetworkUtils().taskListRequest('New');
    setState(() {
      inProgress = false;
      taskItems = data;
    });
  }

  getTaskCounts() async {
    setState(() {
      countInProgress = true;
    });
    var data = await NetworkUtils().taskCount();
    setState(() {
      counts = data;
      for (var element in counts) {
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
      countInProgress = false;
    });
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
                      },
                      child: TaskListView(taskItems: taskItems),
                    )),
        ],
      ),
    );
  }
}
