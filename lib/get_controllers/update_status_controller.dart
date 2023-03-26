
import 'package:get/get.dart';

import '../api/network_utils.dart';
import '../utilities/urls.dart';

class UpdateStatusController extends GetxController{
  var status = "";

  void updateStatus(value) {
    status = value;
    update();
  }

  Future<bool> updateToAPI(String taskID) async {
    final response = await NetworkUtils().getMethod(url: Urls.updateTaskUrl(taskID, status));
    if(response["status"] == "success") {
      return true;
    } else {
      return false;
    }
  }
}