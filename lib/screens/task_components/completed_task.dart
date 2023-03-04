import 'package:flutter/material.dart';

import '../../utilities/application_colors.dart';
import '../../widgets/task_list_item.dart';

class CompletedTask extends StatefulWidget {
  const CompletedTask({Key? key}) : super(key: key);

  @override
  State<CompletedTask> createState() => _CompletedTaskState();
}

class _CompletedTaskState extends State<CompletedTask> {

  bool inProgress = false;

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
        onRefresh: () async {},
        child: ListView.builder(
            itemCount: 2,
            itemBuilder: (context, index) {
              return TaskListItem(
                title: 'New Task',
                description: 'New Task List Design Test',
                date: '07/03/2023',
                type: 'Completed',
                onEditTap: () {},
                onDeleteTap: () {},
              );
            }
        ),
      ),
    );
  }
}
