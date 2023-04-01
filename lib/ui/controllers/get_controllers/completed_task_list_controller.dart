import 'package:get/get.dart';

import '../../../data/models/task_model.dart';
import '../../../data/network_utils.dart';
import '../../../data/urls.dart';

class CompletedTaskListController extends GetxController {
  bool inProgress = false;
  TaskModel completedTaskModel = TaskModel();

  Future<bool> getCompletedTasks() async {
    inProgress = true;
    update();
    var response = await NetworkUtils().getMethod(url: "${Urls.taskListURL}Completed");
    inProgress = false;
    if (response != null) {
      completedTaskModel = TaskModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}