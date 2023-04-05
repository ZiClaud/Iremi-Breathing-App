import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

import '../basics/badge.dart';

// TODO: Fix the size, it occupies the whole screen

showBadgeDialog(context, MyBadge badge) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(badge.getBadge().badgeName),
        content: Center(child: _showBadgeWidget(badge)),
      );
    },
  );
}

Widget _showBadgeWidget(MyBadge badge) {
  return Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      Center(
        child: Icon(
          badge.getBadge().icon,
          size: 100,
          color: (badge.date != "") ? myBluLightDark() : myLockedBadgeColor,
        ),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(badge.getBadge().description),
      ),
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          (badge.date != "")
              ? "Unlocked on " + badge.date
              : "Locked.",
        ),
      ),
    ],
  );
}

/*
class BadgePage extends StatefulWidget {
  List<MyBadge?> myBadges;
  int index;

  BadgePage({Key? key, required this.myBadges, required this.index})
      : super(key: key);

  @override
  State<BadgePage> createState() => _BadgePageState();
}

class _BadgePageState extends State<BadgePage> {
  @override
  Widget build(BuildContext context) {
    MyBadge myBadge = widget.myBadges[widget.index]!;
    return Scaffold(
      appBar: AppBar(
        title: Text(myBadge.getBadge().badgeName),
      ),
      body: _showBadgeWidget(myBadge),
    );
  }
}
*/
