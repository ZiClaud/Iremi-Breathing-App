import 'package:flutter/material.dart';

import '../../utils/defaultWidget.dart';

class UserFormWidget extends StatelessWidget {
  final String? username;
  final String? name;
  final String? surname;
  final String? sex;
  final String? goal;
  final ValueChanged<String> onChangedUsername;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedSurname;
  final ValueChanged<String> onChangedSex;
  final ValueChanged<String> onChangedGoal;

  const UserFormWidget({
    Key? key,
    this.username = '',
    this.name = '',
    this.surname = '',
    this.sex = '',
    this.goal = '',
    required this.onChangedUsername,
    required this.onChangedName,
    required this.onChangedSurname,
    required this.onChangedSex,
    required this.onChangedGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Column(
                children: [
                  TextFormField(
                    initialValue: username,
                    decoration:
                        defaultInputDecoration("Username", Icons.person),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedUsername,
                    validator: (username) =>
                        username != null && username.isEmpty
                            ? 'The username cannot be empty'
                            : null,
                  ),
                  TextFormField(
                    initialValue: name,
                    decoration: defaultInputDecoration(
                        "Name", Icons.nest_cam_wired_stand),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedName,
                    validator: (name) => name != null && name.isEmpty
                        ? 'The name cannot be empty'
                        : null,
                  ),
                  TextFormField(
                    initialValue: surname,
                    decoration: defaultInputDecoration(
                        "Surname (optional)", Icons.surfing),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedSurname,
                  ),
                  TextFormField(
                    initialValue: sex,
                    decoration:
                        defaultInputDecoration("Sex (optional)", Icons.male),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedSex,
                  ),
                  TextFormField(
                    initialValue: goal,
                    decoration: defaultInputDecoration(
                        "Goal (optional)", Icons.circle_outlined),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedGoal,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
}
