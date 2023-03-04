import 'package:flutter/material.dart';

import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/urls.dart';
import '../utilities/utility_functions.dart';
import 'spacing.dart';

AppBar taskAppBar(
    {VoidCallback? onAddTap,
    VoidCallback? onLogOutTap,
    required bool fromHome}) {
  return AppBar(
    backgroundColor: colorGreen,
    flexibleSpace: Container(
      margin: const EdgeInsets.fromLTRB(20, 35, 20, 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.transparent,
            radius: 24,
            child: ClipOval(
              child: Image.memory(showBase64Image(Urls.imageUrl)),
            ),
          ),
          horizontalSpacing(10.0),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Name",
                style: appBarTitle(colorWhite),
              ),
              Text(
                "Email",
                style: appBarSubtitle(colorWhite),
              )
            ],
          )
        ],
      ),
    ),
    actions: fromHome
        ? [
            IconButton(
                onPressed: onAddTap,
                icon: const Icon(Icons.add_circle_outline)),
            IconButton(onPressed: onLogOutTap, icon: const Icon(Icons.logout)),
          ]
        : [],
  );
}
