/*
import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/main_page.dart';

import '../utils/default_widgets.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar("Register"),
      body: ListView(
        children: [
          defaultEditTextFormField("Username", Icons.person),
          defaultEditTextFormField(
              "Name (optional)", Icons.nest_cam_wired_stand),
          defaultEditTextFormField("Surname (optional)", Icons.surfing),
          defaultEditTextFormField("Sex", Icons.male),
          defaultEditTextFormField("Goal", Icons.circle_outlined),
        ],
      ),
      floatingActionButton: defaultFloatingActionButton(
        icon: Icons.navigate_next,
        onPressed: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const MainPage()))
        },
      ),
    );
  }
}
*/
