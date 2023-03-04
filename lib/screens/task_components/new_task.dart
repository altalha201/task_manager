import 'package:flutter/material.dart';
import 'package:task_manager/utilities/application_colors.dart';
import 'package:task_manager/widgets/spacing.dart';
import 'package:task_manager/widgets/task_list_item.dart';

import '../../widgets/dashboard_item.dart';

class NewTask extends StatefulWidget {
  const NewTask({Key? key}) : super(key: key);

  @override
  State<NewTask> createState() => _NewTaskState();
}

class _NewTaskState extends State<NewTask> {
  bool inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Expanded(
                  child: DashboardItem(
                    numberOfTask: 24,
                    type: 'New',
              )),
              Expanded(
                  child: DashboardItem(
                    numberOfTask: 24,
                    type: 'Progress',
              )),
              Expanded(
                  child: DashboardItem(
                    numberOfTask: 24,
                    type: 'Completed',
              )),
              Expanded(
                  child: DashboardItem(
                    numberOfTask: 24,
                    type: 'Canceled',
              )),
            ],
          ),
          verticalSpacing(10.0),
          Expanded(
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
                              type: 'New',
                              onEditTap: () {},
                              onDeleteTap: () {},
                            );
                          }),
                    )),
        ],
      ),
    );
  }
}
