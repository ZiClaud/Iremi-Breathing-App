import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/database/database.dart';
import 'package:iremibreathingapp/utils/myUtils.dart';

import '../../utils/defaultWidget.dart';
import '../../utils/theme.dart';
import 'dbTestAddPage.dart';

class TestDBShowUserPage extends StatefulWidget {
  const TestDBShowUserPage({
    Key? key,
  }) : super(key: key);

  @override
  _NoteDetailPageState createState() => _NoteDetailPageState();
}

class _NoteDetailPageState extends State<TestDBShowUserPage> {
  late MyUser user;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshUser();
  }

  Future refreshUser() async {
    setState(() => isLoading = true);

    try {
      this.user = await MyDatabase.instance.getFirstUser() ??
          MyUser(
              username: "N/A",
              name: "N/A",
              surname: "N/A",
              sex: "N/A",
              goal: "N/A",
              badges: "N/A");
    } catch (e) {
      this.user = MyUser(
          username: "N/A",
          name: "N/A",
          surname: "N/A",
          sex: "N/A",
          goal: "N/A",
          badges: "N/A");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Database error"),
            content: Text(e.toString()),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          );
        },
      );
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text("DEV - Database"),
          backgroundColor: myBluLight,
          actions: [editButton(), deleteButton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : ListView(
                children: [
                  defaultShowTextFormField(
                      "Username", user.username, Icons.person),
                  defaultShowTextFormField(
                      "Name", user.name, Icons.nest_cam_wired_stand),
                  defaultShowTextFormField(
                      "Surname", user.surname!, Icons.surfing),
                  defaultShowTextFormField("Sex", user.sex!, Icons.male),
                  defaultShowTextFormField(
                      "Goal", user.goal, Icons.circle_outlined),
                  defaultShowTextFormField("Badges", user.badges, Icons.badge),
                ],
              ),
      );

  Widget editButton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => TestDBAddUserPage(user: user),
        ));

        refreshUser();
      });

  Widget deleteButton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          try {
            await MyDatabase.instance.delete(user.id!);
          } catch (e) {
            printError(e.toString());
            throw e;
          }
          Navigator.of(context).pop();
        },
      );
}
