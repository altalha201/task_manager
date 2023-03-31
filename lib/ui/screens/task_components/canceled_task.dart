import 'package:flutter/material.dart';

import '../../../data/data_utilities.dart';
import '../../../data/models/task_model.dart';
import '../../../data/network_utils.dart';
import '../../../data/urls.dart';
import '../../utilities/application_colors.dart';
import '../../utilities/get_x_bottom_sheet.dart';
import '../../utilities/get_x_dialog.dart';
import '../../widgets/task_list_item.dart';

class CanceledTask extends StatefulWidget {
  const CanceledTask({Key? key}) : super(key: key);

  @override
  State<CanceledTask> createState() => _CanceledTaskState();
}

class _CanceledTaskState extends State<CanceledTask> {

  bool inProgress = true;
  TaskModel cancelTaskModel = TaskModel();

  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    setState(() {inProgress = true;});

    var response = await NetworkUtils().getMethod(url: "${Urls.taskListURL}Canceled");
    if (response["status"] == "success") {
      cancelTaskModel = TaskModel.fromJson(response);
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
            itemCount: cancelTaskModel.data?.length ?? 0,
            itemBuilder: (context, index) {
              return TaskListItem(
                title: cancelTaskModel.data?[index].title ?? "Unknown",
                description: cancelTaskModel.data?[index].description ?? "Unknown",
                date: cancelTaskModel.data?[index].createdDate ?? "Unknown",
                type: cancelTaskModel.data?[index].status ?? "Unknown",
                onEditTap: () {
                  getTaskUpdateBottomSheet(
                      currentStatus: cancelTaskModel.data?[index].status ?? "Unknown",
                      taskId: cancelTaskModel.data?[index].sId ?? "Unknown",
                      onComplete: () {
                        callData();
                      }
                  );
                },
                onDeleteTap: () {
                  buildGetXDialog(
                      title: "Delete",
                      message: "Want to delete task: ${cancelTaskModel.data?[index].title ?? "Unknown"}",
                      positiveButtonText: "No",
                      positiveTap: () {
                        Navigator.pop(context);
                      },
                      negativeButtonText: "Yes",
                      negativeTap: () async {
                        deleteItem(cancelTaskModel.data?[index].sId ?? "Unknown");
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
