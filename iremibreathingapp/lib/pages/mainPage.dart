import 'package:flutter/material.dart';
import 'package:iremibreathingapp/exercises/deepBreathingExerciseBeginner.dart';

import '../utils/dfaultWidget.dart';
import '../utils/myUtils.dart';
import '../utils/theme.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: defaultAppBar("Welcome to Iremi"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'HOME PAGE',
            ),
            Text(
              'HOME PAGE',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
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
