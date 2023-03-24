import 'package:flutter/material.dart';

import '../../utils/defaultWidget.dart';

class UserFormWidget extends StatelessWidget {
  final String? username;
  final String? name;
  final String? sex;
  final String? goal;
  final ValueChanged<String> onChangedUsername;
  final ValueChanged<String> onChangedName;
  final ValueChanged<String> onChangedSex;
  final ValueChanged<String> onChangedGoal;

  const UserFormWidget({
    Key? key,
    this.username = '',
    this.name = '',
    this.sex = '',
    this.goal = '',
    required this.onChangedUsername,
    required this.onChangedName,
    required this.onChangedSex,
    required this.onChangedGoal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
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
                        "Name (optional)", Icons.badge_outlined),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedName,
                  ),
                  TextFormField(
                    initialValue: sex,
                    decoration:
                        defaultInputDecoration("Sex (optional)", Icons.search),
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    onChanged: onChangedSex,
                  ),
                  TextFormField(
                    initialValue: goal,
                    decoration: defaultInputDecoration(
                        "Goal (optional)", Icons.ads_click),
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
