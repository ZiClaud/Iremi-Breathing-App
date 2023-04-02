import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/old/test/test_play_ground.dart';
import 'package:iremibreathingapp/utils/theme.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _darkMode = true;

  @override
  void initState() {
    super.initState();

    myTheme.setMode(_darkMode);

    myTheme.addListener(() {
      setState(() {
        _darkMode = IremiTheme.isDarkTheme();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TestPlayGround(),
      theme: IremiTheme.lightTheme,
      darkTheme: IremiTheme.darkTheme,
      themeMode: myTheme.iremiTheme,
    );
  }
}