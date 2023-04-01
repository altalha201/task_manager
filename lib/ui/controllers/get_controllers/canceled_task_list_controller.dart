import 'package:get/get.dart';

import '../../../data/models/task_model.dart';
import '../../../data/network_utils.dart';
import '../../../data/urls.dart';

class CanceledTaskListController extends GetxController {
  bool inProgress = false;
  TaskModel canceledTaskModel = TaskModel();

  Future<bool> getCanceledTasks() async {
    inProgress = true;
    update();
    var response = await NetworkUtils().getMethod(url: "${Urls.taskListURL}Canceled");
    inProgress = false;
    if (response != null) {
      canceledTaskModel = TaskModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}