import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/database/database.dart';

import '../utils/defaultWidget.dart';
import 'dbTestAddPage.dart';

class TestDBShowUserPage extends StatefulWidget {
  final int userId;

  const TestDBShowUserPage({
    Key? key,
    required this.userId,
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

    this.user = await MyDatabase.instance.readUser(widget.userId);

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
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
          await MyDatabase.instance.delete(widget.userId);

          Navigator.of(context).pop();
        },
      );
}
