import 'package:get/get.dart';

import '../../screens/task_components/canceled_task.dart';
import '../../screens/task_components/completed_task.dart';
import '../../screens/task_components/new_task.dart';
import '../../screens/task_components/progress_task.dart';

class HomeController extends GetxController {
  int currentIndex = 0;

  final widgetsOptions = [
    const NewTask(),
    const ProgressTask(),
    const CompletedTask(),
    const CanceledTask(),
  ];

  void changeIndex(int newIndex) {
    currentIndex = newIndex;
    update();
  }
}