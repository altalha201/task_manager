import 'package:flutter/material.dart';
import 'package:task_manager/widgets/spacing.dart';

import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';

class DashboardItem extends StatelessWidget {
  const DashboardItem({
    Key? key,
    required this.numberOfTask,
    required this.type,
  }) : super(key: key);

  final int numberOfTask;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      color: colorWhite,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              numberOfTask.toString(),
              style: taskNumber(),
            ),
            verticalSpacing(8.0),
            FittedBox(
              child: Text(type),
            ),
          ],
        ),
      ),
    );
  }
}
