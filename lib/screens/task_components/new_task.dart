import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:task_manager/widgets/spacing.dart';
import 'package:task_manager/widgets/task_list_item.dart';

import '../../api/api_client.dart';
import '../../utilities/toasts.dart';
import '../../utilities/urls.dart';
import '../../utilities/utility_functions.dart';
import '../../widgets/dashboard_item.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool inProgress = false;

  var counts = [];
  int newCount = 0, progressCount = 0, completedCount = 0, canceledCount = 0;

  Future<void> getStatusCount() async {
    setState(() {
      inProgress = true;
    });
    final response = await NetworkUtils().getMethod(Urls.taskCounterURL);
    log(response ?? "Response Not Found");
    /*log(response);
    if (response != null && response["status"] == "success") {
      counts = response["data"];
      log(response["data"]);
      for (var element in counts) {
        switch (element["_id"]) {
          case "New":
            newCount = element["sum"];
            break;
          case "Progress":
            progressCount = element["sum"];
            break;
          case "Completed":
            completedCount = element["sum"];
            break;
          default:
            canceledCount = element["sum"];
            break;
        }
      }
    } else {
      successToast("Try again");
    }*/
    setState(() {
      inProgress = false;
    });
  }

  @override
  initState() {
    super.initState();

    getStatusCount();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: DashboardItem(
                    numberOfTask: newCount,
                    type: 'New',
              )),
              Expanded(
                  child: DashboardItem(
                    numberOfTask: progressCount,
                    type: 'Progress',
              )),
              Expanded(
                  child: DashboardItem(
                    numberOfTask: completedCount,
                    type: 'Completed',
              )),
              Expanded(
                  child: DashboardItem(
                    numberOfTask: canceledCount,
                    type: 'Canceled',
              )),
            ],
          ),
          verticalSpacing(10.0),
          Expanded(
              child: inProgress
                  ? Utility.processingGreen
                  : RefreshIndicator(
                      onRefresh: () async {},
                      child: ListView.builder(
                          itemCount: 2,
                          itemBuilder: (context, index) {
                            return TaskListItem(
                              title: 'New Task',
                              description: 'New Task List Design Test',
                              date: '07/03/2023',
                              type: 'New',
                              onEditTap: () {},
                              onDeleteTap: () {},
                            );
                          }),
                    )),
        ],
      ),
    );
  }
}
