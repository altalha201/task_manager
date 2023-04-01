import 'package:get/get.dart';
import 'package:task_manager/data/network_utils.dart';
import 'package:task_manager/data/urls.dart';

class AddNewTaskController extends GetxController {
  bool inProgress = false;

  Future<bool> addTask({required String title, required String description}) async {
    inProgress = true;
    update();
    final result = await NetworkUtils().postMethod(
      Urls.addTaskURL,
      body: {
        "title" : title,
        "description" : description,
        "status" : "New"
      }
    );
    inProgress = false;
    update();
    if (result != null && result["status"] == "success") {
      return true;
    } else {
      return false;
    }
  }
}