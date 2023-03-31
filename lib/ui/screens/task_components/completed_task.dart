import 'package:flutter/material.dart';

import '../../../data/data_utilities.dart';
import '../../../data/models/task_model.dart';
import '../../../data/network_utils.dart';
import '../../../data/urls.dart';
import '../../utilities/application_colors.dart';
import '../../utilities/get_x_bottom_sheet.dart';
import '../../utilities/get_x_dialog.dart';
import '../../widgets/task_list_item.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({Key? key}) : super(key: key);

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {

  bool inProgress = true;
  TaskModel completedTaskModel = TaskModel();


  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    setState(() {inProgress = true;});

    var response = await NetworkUtils().getMethod(url: "${Urls.taskListURL}Completed");
    if (response["status"] == "success") {
      completedTaskModel = TaskModel.fromJson(response);
    }

    setState(() {inProgress = false;});
  }

  Future<void> deleteItem(id) async {
    setState(() {
      inProgress = true;
    });
    DataUtilities.deleteItem(
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
            itemCount: completedTaskModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return TaskListItem(
                title: completedTaskModel.data?[index].title ?? "Unknown",
                description: completedTaskModel.data?[index].description ?? "Unknown",
                date: completedTaskModel.data?[index].createdDate ?? "Unknown",
                type: completedTaskModel.data?[index].status ?? "Unknown",
                onEditTap: () {
                  getTaskUpdateBottomSheet(
                      currentStatus: completedTaskModel.data?[index].status ?? "Unknown",
                      taskId: completedTaskModel.data?[index].sId ?? "Unknown",
                      onComplete: () {
                        callData();
                      }
                  );
                },
                onDeleteTap: () {
                  buildGetXDialog(
                      title: "Delete",
                      message: "Want to delete task: ${completedTaskModel.data?[index].title ?? "Unknown"}",
                      positiveButtonText: "No",
                      positiveTap: () {
                        Navigator.pop(context);
                      },
                      negativeButtonText: "Yes",
                      negativeTap: () async {
                        deleteItem(completedTaskModel.data?[index].sId ?? "Unknown");
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
