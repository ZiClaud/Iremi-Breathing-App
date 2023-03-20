import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/mainPage.dart';

import '../utils/defaultWidget.dart';

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
      // TODO: Add advanced - Shows milliseconds
      body: ListView(
        children: [
          defaultEditTextFormField("Username", Icons.person),
          defaultEditTextFormField("Name (optional)", Icons.nest_cam_wired_stand),
          defaultEditTextFormField("Surname (optional)", Icons.surfing),
          defaultEditTextFormField("Sex", Icons.male),
          defaultEditTextFormField("Goal", Icons.circle_outlined),
        ],
      ),
      floatingActionButton: defaultFloatingActionButton(
        icon: Icons.navigate_next,
        onPressed: () => {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const MainPage()))
        },
      ),
    );
  }
}
