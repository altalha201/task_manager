import 'package:flutter/material.dart';

import '../data/auth_utils.dart';
import '../utilities/application_colors.dart';
import '../utilities/text_styles.dart';
import '../utilities/urls.dart';
import '../utilities/utility_functions.dart';
import 'spacing.dart';

class ProfileBar extends StatefulWidget {
  const ProfileBar({Key? key, this.onAddTap, this.onLogOutTap, this.fromHome, this.onProfileTap}) : super(key: key);

  final bool? fromHome;
  final VoidCallback? onAddTap;
  final VoidCallback? onLogOutTap;
  final VoidCallback? onProfileTap;

  @override
  State<ProfileBar> createState() => _ProfileBarState();
}

class _ProfileBarState extends State<ProfileBar> {

  @override
  Widget build(BuildContext context) {

    var imgTxt = AuthUtils.profilePic ?? Urls.imageUrl;

    if (imgTxt == "") {
      imgTxt = Urls.imageUrl;
    }

    return Container(
      height: AppBar().preferredSize.height,
      width: AppBar().preferredSize.width,
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      color: colorGreen,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
            onTap: widget.onProfileTap,
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: Colors.transparent,
                  radius: 24,
                  child: ClipOval(
                    child: Image.memory(Utility.showBase64Image(imgTxt), fit: BoxFit.fitWidth, width: 48,),
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
          const Spacer(),
          Visibility(
            visible: widget.fromHome ?? false,
            child: IconButton(
                onPressed: widget.onAddTap,
                icon: const Icon(Icons.add_circle_outline, color: colorWhite,)),
          ),
          Visibility(
            visible: widget.fromHome ?? false,
            child: IconButton(
                onPressed: widget.onLogOutTap,
                icon: const Icon(Icons.logout, color: colorWhite,))
          ),
        ],
      ),
    );
  }
}

