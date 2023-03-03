import 'package:flutter/material.dart';
import 'package:task_manager/utilities/application_colors.dart';

class AppNavBar extends StatefulWidget {
  const AppNavBar({Key? key, required this.currentIndex, this.onTap}) : super(key: key);

  final int currentIndex;
  final Function(dynamic)? onTap;

  @override
  State<AppNavBar> createState() => _AppNavBarState();
}

class _AppNavBarState extends State<AppNavBar> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items:  const [
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_sharp,),
          label: "New"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.access_time_sharp,),
            label: "Progress"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.check_circle_outline_sharp,),
            label: "Completed"
        ),
        BottomNavigationBarItem(
            icon: Icon(Icons.cancel_outlined,),
            label: "Canceled"
        )
      ],
      iconSize: 28,
      backgroundColor: colorGreen,
      fixedColor: colorWhite,
      // selectedItemColor: colorGreen,
      unselectedItemColor: colorDarkBlue,
      showUnselectedLabels: true,
      elevation: 10,
      currentIndex: widget.currentIndex,
      type: BottomNavigationBarType.fixed,
      onTap: (value) {
        if (widget.onTap != null) {
          widget.onTap!(value);
        }
      },
    );
  }
}
