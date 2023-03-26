import 'package:flutter/material.dart';
import 'package:task_manager/utilities/get_x_dialog.dart';

import '../../api/network_utils.dart';
import '../../utilities/application_colors.dart';
import '../../utilities/get_x_bottom_sheet.dart';
import '../../utilities/urls.dart';
import '../../utilities/utility_functions.dart';
import '../../widgets/task_list_item.dart';

class CanceledTask extends StatefulWidget {
  const CanceledTask({Key? key}) : super(key: key);

  @override
  State<CanceledTask> createState() => _CanceledTaskState();
}

class _CanceledTaskState extends State<CanceledTask> {

  bool inProgress = true;

  List taskItems = [];

  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    setState(() {inProgress = true;});

    var response = await NetworkUtils().getMethod(url: "${Urls.taskListURL}Canceled");
    if (response["status"] == "success") {
      var data = response["data"];
      taskItems = data;
    }

    setState(() {inProgress = false;});
  }

  Future<void> deleteItem(id) async {
    setState(() {
      inProgress = true;
    });
    Utility.deleteItem(
        id,
        onSuccess: () {
          callData();
        }
    );
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
                  getTaskUpdateBottomSheet(
                      currentStatus: taskItems[index]['status'],
                      taskId: taskItems[index]['_id'],
                      onComplete: () {
                        callData();
                      }
                  );
                },
                onDeleteTap: () {
                  buildGetXDialog(
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
