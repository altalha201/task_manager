
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../../data/data_utilities.dart';
import '../../utilities/get_x_dialog.dart';

class TaskDeleteController {
  static Future<void> deleteTask(
      {required String title,
      required String id,
      required VoidCallback onComplete}) async {
    buildGetXDialog(
        title: "Delete",
        message: "Want to delete task: $title",
        positiveButtonText: "No",
        positiveTap: () {
          Get.back();
        },
        negativeButtonText: "Yes",
        negativeTap: () async {
          await DataUtilities.deleteItem(id, onSuccess: onComplete);
          Get.back();
        }
    );
  }
}
