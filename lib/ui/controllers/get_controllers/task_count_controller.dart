import 'package:get/get.dart';

import '../../../data/models/task_count_model.dart';
import '../../../data/network_utils.dart';
import '../../../data/urls.dart';

class TaskCountController extends GetxController {
  bool inProgress = false;

  TaskCountModel taskCountModel = TaskCountModel();

  int newTasks = 0;
  int progressingTask = 0;
  int completedTask = 0;
  int canceledTask = 0;

  Future<bool> getTaskCounts() async {
    inProgress = true;
    update();
    var response = await NetworkUtils().getMethod(url: Urls.taskCounterURL);
    inProgress = false;
    if (response != null) {
      taskCountModel = TaskCountModel.fromJson(response);
      var data = taskCountModel.data ?? [];
      newTasks = 0; progressingTask = 0; completedTask = 0; canceledTask = 0;
      for (var element in data) {
        switch (element.sId) {
          case "New": {
            newTasks = element.sum ?? 0;
            break;
          }
          case "Completed" : {
            completedTask = element.sum ?? 0;
            break;
          }
          case "Progress" : {
            progressingTask = element.sum ?? 0;
            break;
          }
          case "Canceled" : {
            canceledTask = element.sum ?? 0;
            break;
          }
        }
      }
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}