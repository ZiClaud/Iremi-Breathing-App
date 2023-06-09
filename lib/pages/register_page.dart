import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/user.dart';

import '../database/database.dart';
import '../database/database_dialogs.dart';
import '../database/forms/user_form_widget.dart';
import '../utils/default_widgets.dart';
import 'home_page.dart';

class RegisterPageDB extends StatefulWidget {
  final MyUser? user;

  const RegisterPageDB({Key? key, this.user}) : super(key: key);

  @override
  State<RegisterPageDB> createState() => _RegisterPageDBState();
}

class _RegisterPageDBState extends State<RegisterPageDB> {
  final _formKey = GlobalKey<FormState>();
  late String username;
  late String name;
  late String sex;
  late String goal;

  @override
  void initState() {
    super.initState();

    username = widget.user?.username ?? '';
    name = widget.user?.name ?? '';
    sex = widget.user?.sex ?? '';
    goal = widget.user?.goal ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text((widget.user == null) ? "Register" : "Edit user")),
        body: Column(
          children: [
            Form(
              key: _formKey,
              child: UserFormWidget(
                username: username,
                name: name,
                sex: sex,
                goal: goal,
                onChangedUsername: (username) =>
                    setState(() => this.username = username),
                onChangedName: (name) => setState(() => this.name = name),
                onChangedSex: (sex) => setState(() => this.sex = sex),
                onChangedGoal: (goal) => setState(() => this.goal = goal),
              ),
            ),
            if (widget.user == null && (username == ""))
              defaultOutlinedButton(
                context,
                "Continue without account",
                Icons.person_off,
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                    (route) => false,
                  );
                },
              ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.navigate_next),
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
          await DBMyUser().updateUser(widget.user!.copy(
            username: username,
            name: name,
            sex: sex,
            goal: goal,
          ));
        } else {
          await DBMyUser().createUser(MyUser(
            username: username,
            name: name,
            sex: sex,
            goal: goal,
          ));
        }
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => HomePage()),
          (route) => false,
        );
      } catch (e) {
        defaultDatabaseErrorDialog(context, e.toString());
      }
    }
  }
}
