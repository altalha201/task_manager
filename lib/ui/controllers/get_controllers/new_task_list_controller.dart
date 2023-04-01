import 'package:get/get.dart';

import '../../../data/models/task_model.dart';
import '../../../data/network_utils.dart';
import '../../../data/urls.dart';

class NewTaskListController extends GetxController {
  bool inProgress = false;
  TaskModel newTaskModel = TaskModel();

  Future<bool> getAllNewTask() async {
    inProgress = true;
    update();
    var response = await NetworkUtils().getMethod(url: "${Urls.taskListURL}New");
    inProgress = false;
    if(response != null) {
      newTaskModel = TaskModel.fromJson(response);
      update();
      return true;
    } else {
      update();
      return false;
    }
  }
}