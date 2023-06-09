import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/register_page.dart';
import 'package:iremibreathingapp/pages/settings_page.dart';

import '../basics/user.dart';
import '../database/getters.dart';
import '../utils/default_widgets.dart';

class UserPage extends StatefulWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  MyUser? _user;

  @override
  void initState() {
    super.initState();
    _getUser();
  }

  Future<void> _getUser() async {
    MyUser? user = await Getters.getUserDB(context);
    if (user != null) {
      setState(() {
        _user = user;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: _showUserWidget(_user),
          ),
          (_user != null)
              ? defaultOutlinedButton(
                  context,
                  "Edit User",
                  Icons.edit,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPageDB(user: _user),
                      ),
                    );
                  },
                )
              : defaultOutlinedButton(
                  context,
                  "Register User",
                  Icons.person_add,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RegisterPageDB(user: _user),
                      ),
                    );
                  },
                ),
          defaultOutlinedButton(
            context,
            "Settings",
            Icons.settings,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const SettingsPage(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

Widget _showUserWidget(MyUser? user) {
  return user != null
      ? ListView(
          children: [
            defaultInputDecorator("Username", user.username, Icons.person),
            if (user.name.isNotEmpty)
              defaultInputDecorator("Name", user.name, Icons.badge_outlined),
            if (user.sex.isNotEmpty)
              defaultInputDecorator("Sex", user.sex, Icons.search),
            if (user.goal.isNotEmpty)
              defaultInputDecorator("Goal", user.goal, Icons.ads_click),
          ],
        )
      : const SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Center(
            child: Text('No user found'),
          ),
        );
}
