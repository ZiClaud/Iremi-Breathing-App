import 'package:flutter/material.dart';

import '../utils/defaultWidget.dart';

class exerciseAddPage extends StatefulWidget {
  const exerciseAddPage({Key? key}) : super(key: key);

  @override
  State<exerciseAddPage> createState() => _exerciseAddPageState();
}

class _exerciseAddPageState extends State<exerciseAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar("Add custom exercise!"), // TODO: Add advanced - Shows milliseconds
      body: ListView(
        children: [
          defaultEditTextFormField("Name", Icons.keyboard_double_arrow_up),
          defaultEditTextFormField("Description", Icons.description),
          defaultEditTextFormField("Notes", Icons.note),
          defaultEditTextFormField("Steps", Icons.select_all),
          defaultEditTextFormField("InhaleDuration", Icons.circle),
          defaultEditTextFormField("HoldMiddleDuration", Icons.change_circle),
          defaultEditTextFormField("ExhaleDuration", Icons.circle_outlined),
          defaultEditTextFormField(
              "HoldEndDuration", Icons.change_circle_outlined),
          defaultEditTextFormField("Times", Icons.repeat),
        ],
      ),
      floatingActionButton: defaultFloatingActionButton(
        icon: Icons.navigate_next,
        onPressed: () => {
          null //TODO: Change
        },
      ),
    );
  }
}
