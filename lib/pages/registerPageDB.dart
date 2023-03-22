import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/pages/mainPage.dart';

import '../database/database.dart';
import '../database/forms/userFormWidget.dart';
import '../utils/defaultWidget.dart';

class RegisterPageDB extends StatefulWidget {
  final MyUser? user;

  RegisterPageDB({Key? key, this.user}) : super(key: key);

  @override
  State<RegisterPageDB> createState() => _RegisterPageDBState();
}

class _RegisterPageDBState extends State<RegisterPageDB> {
  final _formKey = GlobalKey<FormState>();
  late String username;
  late String name;
  late String? surname;
  late String? sex;
  late String goal;

  @override
  void initState() {
    super.initState();

    username = widget.user?.username ?? 'we';
    name = widget.user?.name ?? '';
    surname = widget.user?.surname ?? '';
    sex = widget.user?.sex ?? '';
    goal = widget.user?.goal ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: (widget.user == null) ? defaultAppBar("Register") : defaultAppBar("Edit user"),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: UserFormWidget(
                username: username,
                name: name,
                surname: surname,
                sex: sex,
                goal: goal,
                onChangedUsername: (username) =>
                    setState(() => this.username = username),
                onChangedName: (name) => setState(() => this.name = name),
                onChangedSurname: (surname) =>
                    setState(() => this.surname = surname),
                onChangedSex: (sex) => setState(() => this.sex = sex),
                onChangedGoal: (goal) => setState(() => this.goal = goal),
              ),
            ),
            if (widget.user == null)
              defaultOutlinedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MainPage()));
                },
                child: defaultText("Continue without account"),
              ),
          ],
        ),
        floatingActionButton: defaultFloatingActionButton(
          icon: Icons.navigate_next,
          onPressed: () => {
            addOrUpdateUser(),
          },
        ));
  }

  Widget buildButton() {
    final isFormValid = username.isNotEmpty && name.isNotEmpty;

    return Padding(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        child: FloatingActionButton(onPressed: () {
          if (isFormValid) {
            addOrUpdateUser();
          }
        }));
  }

  void addOrUpdateUser() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.user != null;

      try {
        if (isUpdating) {
          await _updateUser();
        } else {
          await _addUser();
        }
      } catch (e) {
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

      Navigator.of(context).pop();
    }
  }

  Future _updateUser() async {
    final user = widget.user!.copy(
      username: username,
      name: name,
      surname: surname,
      sex: sex,
      goal: goal,
    );

    try {
      await MyDatabase.instance.update(user);
      Navigator.of(context).pop();
    } catch (e) {
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
  }

  Future _addUser() async {
    final user = MyUser(
      username: username,
      name: name,
      surname: surname,
      sex: sex,
      goal: goal,
    );

    try {
      await MyDatabase.instance.create(user);
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
      );
    } catch (e) {
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
  }
}
