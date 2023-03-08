import '../api/network_utils.dart';

class TaskUtils {

  List? newTaskList, progressTaskList, completedTaskList, canceledTaskList;

  static Future<List> getTask(status) async {
    var data = await NetworkUtils().taskListRequest(status);
    return data;
  }

  Future<void> getAllTaskLists() async {
    newTaskList = await getTask("New");
    progressTaskList = await getTask("Progress");
    completedTaskList = await getTask("Completed");
    canceledTaskList = await getTask("Canceled");
  }
}