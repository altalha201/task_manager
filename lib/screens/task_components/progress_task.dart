import 'package:flutter/material.dart';

import '../../api/api_client.dart';
import '../../utilities/application_colors.dart';
import '../../widgets/task_list_view.dart';

class ProgressTask extends StatefulWidget {
  const ProgressTask({Key? key}) : super(key: key);

  @override
  State<ProgressTask> createState() => _ProgressTaskState();
}

class _ProgressTaskState extends State<ProgressTask> {

  bool inProgress = true;

  List taskItems = [];

  @override
  void initState() {
    callData();
    super.initState();
  }

  callData() async {
    setState(() {inProgress = true;});
    var data = await NetworkUtils().taskListRequest('Progress');
    setState(() {
      inProgress = false;
      taskItems = data;
    });

  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: inProgress
          ? const Center(
        child: CircularProgressIndicator(
          color: colorGreen,
        ),
      )
          : RefreshIndicator(
        onRefresh: () async {
          callData();
        },
        child: TaskListView(taskItems: taskItems),
      ),
    );
  }
}
