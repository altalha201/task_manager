import 'package:flutter/material.dart';

import '../../api/network_utils.dart';
import '../../utilities/application_colors.dart';
import '../../utilities/bottom_sheet.dart';
import '../../utilities/dialog.dart';
import '../../utilities/toasts.dart';
import '../../widgets/task_list_item.dart';

class ProgressTask extends StatefulWidget {
  const ProgressTask({Key? key}) : super(key: key);

  @override
  State<ProgressTask> createState() => _ProgressTaskState();
}

class _ProgressTaskState extends State<ProgressTask> {

  bool inProgress = true;

  List taskItems = [];

  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    setState(() {inProgress = true;});
    var data = await NetworkUtils().taskListRequest('Progress', context: context);
    setState(() {
      inProgress = false;
      taskItems = data;
    });
  }

  Future<void> deleteItem(id) async {
    setState(() {
      inProgress = true;
    });
    var result = await NetworkUtils().deleteTask(id);
    if (result) {
      callData();
      successToast("Task Delete Success");
    } else {
      errorToast("Task delete failed!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: inProgress
          ? const Center(
        child: CircularProgressIndicator(
          color: colorGreen,
        ),
      )
          : RefreshIndicator(
        onRefresh: () async {
          callData();
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
      ),
    );
  }
}
