import 'package:flutter/material.dart';

import '../../../data/data_utilities.dart';
import '../../../data/models/task_model.dart';
import '../../../data/network_utils.dart';
import '../../../data/urls.dart';
import '../../utilities/application_colors.dart';
import '../../utilities/get_x_bottom_sheet.dart';
import '../../utilities/get_x_dialog.dart';
import '../../widgets/task_list_item.dart';

class ProgressTask extends StatefulWidget {
  const ProgressTask({Key? key}) : super(key: key);

  @override
  State<ProgressTask> createState() => _ProgressTaskState();
}

class _ProgressTaskState extends State<ProgressTask> {

  bool inProgress = true;
  TaskModel progressTaskModel = TaskModel();

  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    setState(() {inProgress = true;});

    var response = await NetworkUtils().getMethod(url: "${Urls.taskListURL}Progress");
    if (response["status"] == "success") {
      progressTaskModel = TaskModel.fromJson(response);
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
            itemCount: progressTaskModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return TaskListItem(
                title: progressTaskModel.data?[index].title ?? "Unknown",
                description: progressTaskModel.data?[index].description ?? "Unknown",
                date: progressTaskModel.data?[index].createdDate ?? "Unknown",
                type: progressTaskModel.data?[index].status ?? "Unknown",
                onEditTap: () {
                  getTaskUpdateBottomSheet(
                      currentStatus: progressTaskModel.data?[index].status ?? "Unknown",
                      taskId: progressTaskModel.data?[index].sId ?? "",
                      onComplete: () {
                        callData();
                      }
                  );
                },
                onDeleteTap: () {
                  buildGetXDialog(
                      title: "Delete",
                      message: "Want to delete task: ${progressTaskModel.data?[index].title ?? "Unknown"}",
                      positiveButtonText: "No",
                      positiveTap: () {
                        Navigator.pop(context);
                      },
                      negativeButtonText: "Yes",
                      negativeTap: () async {
                        deleteItem(progressTaskModel.data?[index].sId ?? "");
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
