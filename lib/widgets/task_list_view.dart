import 'package:flutter/material.dart';
import 'package:task_manager/widgets/task_list_item.dart';

class TaskListView extends StatelessWidget {
  const TaskListView({
    Key? key,
    required this.taskItems,
  }) : super(key: key);

  final List taskItems;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: taskItems.length,
        itemBuilder: (context, index) {
          return TaskListItem(
            title: taskItems[index]['title'],
            description: taskItems[index]['description'],
            date: taskItems[index]['createdDate'],
            type: taskItems[index]['status'],
            onEditTap: () {},
            onDeleteTap: () {},
          );
        });
  }
}