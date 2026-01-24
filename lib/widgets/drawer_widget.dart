import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../basics/badge.dart';
import '../pages/home_page.dart';
import '../pages/settings_page.dart';
import '../utils/my_utils.dart';
import '../utils/theme.dart';
import 'loading_screen_widget.dart';

/// Drawer
Widget defaultDrawer(BuildContext context) {
  Future<void> openGitUrl(BuildContext context) async {
    final Uri url = Uri.parse('https://github.com/ZiClaud/Iremi-Breathing-App');

    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not open the link')),
        );
      }
    }
  }

  return Drawer(
    child: Column(
      children: <Widget>[
        DrawerHeader(
          decoration: BoxDecoration(
            color: myBluNeutral(),
          ),
          child: defaultLogoWidget(),
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.home, color: myWhiteBlack()),
              const Padding(padding: EdgeInsets.only(right: 10.0)),
              const Text('Home'),
            ],
          ),
          onTap: () {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
                (route) => false);
          },
        ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.settings, color: myWhiteBlack()),
              const Padding(padding: EdgeInsets.only(right: 10.0)),
              const Text('Settings'),
            ],
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            );
          },
        ),
        const Spacer(),
        if (isDev)
          ListTile(
            title: Row(
              children: [
                Icon(Icons.star, color: myWhiteBlack()),
                const Padding(padding: EdgeInsets.only(right: 10.0)),
                const Text('Rate the App'),
              ],
            ),
            onTap: () {
              // TODO: Add link to rate the app
              // TODO: Achievement.addAchievement(PossibleBadges.rater, context);
            },
          ),
        if (isDev)
          ListTile(
            title: Row(
              children: [
                Icon(Icons.share, color: myWhiteBlack()),
                const Padding(padding: EdgeInsets.only(right: 10.0)),
                const Text('Share'),
              ],
            ),
            onTap: () {
              // TODO: Add link to share the app
              // TODO: Achievement.addAchievement(PossibleBadges.sharingIsCaring, context);
            },
          ),
        ListTile(
          title: Row(
            children: [
              Icon(Icons.android, color: myWhiteBlack()),
              const Padding(padding: EdgeInsets.only(right: 10.0)),
              const Text('Star the Repo'),
            ],
          ),
          onTap: () {
            Achievement.addAchievement(PossibleBadges.supporter, context);
            openGitUrl(context);
          },
        ),
      ],
    ),
  );
}
