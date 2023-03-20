import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/registerPage.dart';
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
      home: const RegisterPage(),
    );
  }
}
