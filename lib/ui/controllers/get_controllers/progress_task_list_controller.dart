import 'package:get/get.dart';

import '../../../data/models/task_model.dart';
import '../../../data/network_utils.dart';
import '../../../data/urls.dart';

class ProgressTaskListController extends GetxController {
  bool inProgress = false;
  TaskModel progressTaskModel = TaskModel();

  Future<bool> getProgressTasks() async {
    inProgress = true;
    update();
    var response = await NetworkUtils().getMethod(url: "${Urls.taskListURL}Progress");
    inProgress = false;
    if (response != null) {
      progressTaskModel = TaskModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}