import 'package:flutter/material.dart';

import '../basics/badge.dart';
import '../pages/badge_info_page.dart';
import '../utils/theme.dart';

/// Badge views
Widget defaultBadgeView(BuildContext context, badge) {
  if (badge.date != "") {
    return defaultUnlockedBadgeView(context, badge);
  } else {
    return defaultLockedBadgeView(context, badge);
  }
}

void Function() _onTapViewBadge(BuildContext context, MyBadge badge) {
  return () {
    showBadgeDialog(context, badge);
  };
}

Widget defaultUnlockedBadgeView(BuildContext context, MyBadge badge) {
  // TODO: Unite UnlockedView with LockedView in a single widget
  String name = badge.getBadge().badgeName;
  IconData icon = badge.getBadge().icon;
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: GestureDetector(
      onTap: _onTapViewBadge(context, badge),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: myBluLightDark(),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            Text(name, style: defaultSmallButtonTextStyle(), maxLines: 2),
          ],
        ),
      ),
    ),
  );
}

Widget defaultLockedBadgeView(BuildContext context, PossibleBadges badge) {
  // TODO: Unite UnlockedView with LockedView in a single widget
  String name = badge.badgeName;
  IconData icon = badge.icon;
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: GestureDetector(
      onTap: _onTapViewBadge(context, MyBadge(id: badge.id, date: "")),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: myLockedBadgeColor(),
          shape: BoxShape.circle,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 50,
              color: Colors.white,
            ),
            Text(name, style: defaultSmallButtonTextStyle(), maxLines: 2),
          ],
        ),
      ),
    ),
  );
}
