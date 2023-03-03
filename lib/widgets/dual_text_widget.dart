import 'package:flutter/material.dart';
import 'package:task_manager/widgets/spacing.dart';

import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';

class DualTextWidget extends StatelessWidget {

  final String question;
  final String todo;
  final VoidCallback? onTap;

  const DualTextWidget({
    Key? key,
    required this.question,
    required this.todo,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      hoverColor: Colors.transparent,
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            question,
            style: authTextButton(colorDarkBlue),
          ),
          horizontalSpacing(4.0),
          Text(
            todo,
            style: authTextButton(colorGreen),
          ),
        ],
      ),
    );
  }
}
