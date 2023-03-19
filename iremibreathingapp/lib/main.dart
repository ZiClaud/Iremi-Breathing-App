import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/mainPage.dart';
import 'package:iremibreathingapp/pages/oldMainPage.dart';
import 'package:iremibreathingapp/pages/page.dart';
import 'package:iremibreathingapp/utils/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: myBluLightMaterial,
      ),
      home: const MainPage(), // TODO: Only change this
    );
  }
}
