import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/pages/mainPage.dart';

import '../database/database.dart';
import '../database/forms/userFormWidget.dart';
import '../utils/defaultWidget.dart';
import '../utils/myUtils.dart';

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

    username = widget.user?.username ?? '';
    name = widget.user?.name ?? '';
    surname = widget.user?.surname ?? '';
    sex = widget.user?.sex ?? '';
    goal = widget.user?.goal ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text((widget.user == null) ? "Register" : "Edit user")),
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
            if (widget.user == null && (username == "" || name == ""))
              OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MainPage()),
                    (route) => false,
                  );
                },
                child: defaultText("Continue without account"),
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.navigate_next),
          onPressed: () => {
            _addOrUpdateUser(),
          },
        ));
  }

  void _addOrUpdateUser() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.user != null;

      try {
        if (isUpdating) {
          await MyDatabase.instance.updateUser(widget.user!.copy(
            username: username,
            name: name,
            surname: surname,
            sex: sex,
            goal: goal,
          ));
        } else {
          await MyDatabase.instance.createUser(MyUser(
            username: username,
            name: name,
            surname: surname,
            sex: sex,
            goal: goal,
          ));
        }
      } catch (e) {
        defaultDatabaseErrorDialog(context, e);
      }
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => const MainPage()),
            (route) => false,
      );
    }
  }
}
