import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:iremibreathingapp/pages/main_page.dart';

import '../database/database.dart';
import '../database/forms/user_form_widget.dart';
import '../utils/default_widgets.dart';
import '../utils/my_utils.dart';
import 'home_page.dart';

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
              OutlinedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const HomePage()),
                    (route) => false,
                  );
                },
                child: defaultButtonText("Continue without account"),
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
          MaterialPageRoute(builder: (context) => const HomePage()),
          (route) => false,
        );
      } catch (e) {
        defaultDatabaseErrorDialog(context, e.toString());
      }
    }
  }
}
