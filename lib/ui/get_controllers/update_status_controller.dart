import 'package:get/get.dart';

import '../../data/network_utils.dart';
import '../../data/urls.dart';


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