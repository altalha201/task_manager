import 'package:flutter/material.dart';

import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/urls.dart';
import '../utilities/utility_functions.dart';
import 'spacing.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({Key? key, this.onAddTap, this.onLogOutTap, this.fromHome, this.onProfileTap}) : super(key: key);

  final bool? fromHome;
  final VoidCallback? onAddTap;
  final VoidCallback? onLogOutTap;
  final VoidCallback? onProfileTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppBar().preferredSize.height,
      width: AppBar().preferredSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: colorGreen,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: onProfileTap,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 24,
                  child: ClipOval(
                    child: Image.memory(Utility().showBase64Image(Urls.imageUrl)),
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
                ),
              ],
            ),
          ),
          const Spacer(),
          Visibility(
            visible: fromHome ?? false,
            child: IconButton(
                onPressed: onAddTap,
                icon: const Icon(Icons.add_circle_outline, color: colorWhite,)),
          ),
          Visibility(
            visible: fromHome ?? false,
            child: IconButton(
                onPressed: onLogOutTap,
                icon: const Icon(Icons.logout, color: colorWhite,))
          ),
        ],
      ),
    );
  }
}

