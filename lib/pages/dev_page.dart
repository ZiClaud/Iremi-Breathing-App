import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/default_widgets.dart';
import 'package:iremibreathingapp/utils/my_utils.dart';

import '../basics/badge.dart';

class DevPage extends StatefulWidget {
  const DevPage({Key? key}) : super(key: key);

  @override
  State<DevPage> createState() => _DevPageState();
}

class _DevPageState extends State<DevPage> {
  Future<void> _doDevStuff1(BuildContext context) async {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("DEV Page"),
        actions: [
          if (isDev)
            IconButton(
              icon: const Icon(Icons.code),
              onPressed: () {
                _doDevStuff1(context);
              },
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 3,
            child: _getUserListView(context),
          ),
          Expanded(
            flex: 1,
            child: _getAchievementListView(context),
          ),
        ],
      ),
    );
  }

  Widget _getAchievementListView(BuildContext context) {
    return ListView.builder(
      itemCount: _myBadgeExample().length,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return defaultBadgeView(context, _myBadgeExample()[index]);
      },
    );
  }

  List<MyBadge> _myBadgeExample() {
    List<MyBadge> allBadges = [];

    for (PossibleBadges possibleBadges in PossibleBadges.values) {
      allBadges.add(MyBadge(id: possibleBadges.id, date: "18/03/2023"));
    }

    return allBadges;
  }

  Widget _getUserListView(BuildContext context) {
    return ListView(
      children: [
        defaultInputDecorator("Username", "DEV", Icons.person),
        defaultInputDecorator("Name", "Developer", Icons.badge_outlined),
        defaultInputDecorator("Sex", "No", Icons.search),
        defaultInputDecorator("Goal", "24h/day", Icons.ads_click),
      ],
    );
  }
}
