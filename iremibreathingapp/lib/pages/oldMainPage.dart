import 'package:flutter/material.dart';
import 'package:iremibreathingapp/exercises/deepBreathingExerciseBeginner.dart';
import 'package:iremibreathingapp/pages/page.dart';

import '../utils/dfaultWidget.dart';
import '../utils/myUtils.dart';
import '../utils/theme.dart';

class OldMainPage extends StatefulWidget {
  const OldMainPage({Key? key}) : super(key: key);

  @override
  State<OldMainPage> createState() => _OldMainPageState();
}

class _OldMainPageState extends State<OldMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar("Welcome to Iremi"),
      body: Center(
        child: null//BallAnimation()
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          navigateToExercisePage(this, DeepBreathingExerciseBeginner())
        },
        foregroundColor: myWhite,
        backgroundColor: myBluLight,
        tooltip: 'Increment',
        child: Icon(Icons.navigate_next),
      ),
    );
  }
}
