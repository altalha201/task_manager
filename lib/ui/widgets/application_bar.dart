import 'package:flutter/material.dart';

import '../../data/auth_utils.dart';
import '../../data/urls.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/ui_utility.dart';
import 'spacing.dart';


AppBar applicationBar(
    {bool? fromHome,
    VoidCallback? onProfileTap,
    VoidCallback? onAddTap,
    VoidCallback? onLogOutTap}) {

  var imgTxt = AuthUtils.profilePic ?? Urls.imageUrl;

  if (imgTxt == "") {
    imgTxt = Urls.imageUrl;
  }

  return AppBar(
    backgroundColor: colorGreen,
    flexibleSpace: SafeArea(
      child: Padding(
        padding: fromHome ?? false
                  ? const EdgeInsets.symmetric(horizontal: 16.0)
                  : const EdgeInsets.symmetric(horizontal: 48.0),
        child: InkWell(
          onTap: onProfileTap,
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 24,
                child: ClipOval(
                  child: Image.memory(
                    UIUtility.showBase64Image(imgTxt),
                    fit: BoxFit.fitWidth,
                    width: 48,
                  ),
                ),
              ),
              horizontalSpacing(10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    child: Text(
                      "${AuthUtils.firstName ?? ""} ${AuthUtils.lastName}",
                      style: appBarTitle(colorWhite),
                    ),
                  ),
                  FittedBox(
                    child: Text(
                      AuthUtils.email ?? 'Unknown',
                      style: appBarSubtitle(colorWhite),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    ),
    actions: [
      Visibility(
        visible: fromHome ?? false,
        child: IconButton(
            onPressed: onAddTap,
            icon: const Icon(
              Icons.add_circle_outline,
              color: colorWhite,
            )),
      ),
      Visibility(
          visible: fromHome ?? false,
          child: IconButton(
              onPressed: onLogOutTap,
              icon: const Icon(
                Icons.logout,
                color: colorWhite,
              ))
      ),
    ],
  );
}
