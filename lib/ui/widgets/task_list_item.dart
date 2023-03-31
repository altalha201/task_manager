import 'package:flutter/material.dart';

import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import 'spacing.dart';

// ignore: must_be_immutable
class TaskListItem extends StatelessWidget {
  TaskListItem(
      {Key? key,
      required this.title,
      required this.description,
      required this.date,
      required this.type,
      required this.onEditTap,
      required this.onDeleteTap})
      : super(key: key);

  final String title, description, date, type;
  final VoidCallback onEditTap, onDeleteTap;

  var chipColor = colorBlue;

  void setChipColor() {
    switch (type) {
      case 'Progress' : {
        chipColor = Colors.purple;
        break;
      }
      case 'Completed' : {
        chipColor = colorGreen;
        break;
      }
      case 'Canceled' : {
        chipColor = colorRed;
        break;
      }
      default : {
        chipColor = colorBlue;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    setChipColor();
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10)
      ),
      margin: const EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: taskTitle()),
            verticalSpacing(6),
            Text(
              description,
              maxLines: 2,
            ),
            verticalSpacing(8),
            Text('Date : $date'),
            verticalSpacing(8),
            Row(
              children: [
                TaskStatus(chipColor: chipColor, type: type),
                const Spacer(),
                IconButton(
                    onPressed: onEditTap,
                    icon: const Icon(Icons.edit_rounded, size: 18, color: colorGreen,)
                ),
                IconButton(
                    onPressed: onDeleteTap,
                    icon: const Icon(Icons.delete_outline, size: 18, color: colorRed,)
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class TaskStatus extends StatelessWidget {
  const TaskStatus({
    Key? key,
    required this.chipColor,
    required this.type,
  }) : super(key: key);

  final Color chipColor;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 100,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: chipColor
      ),
      child: Center(
        child: Text(type, style: statusStyle(colorWhite),),
      ),
    );
  }
}
