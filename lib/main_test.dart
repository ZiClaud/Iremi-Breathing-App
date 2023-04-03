/*
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
*/

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Google Sign-In Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatelessWidget {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: <String>[
      'email',
      'https://www.googleapis.com/auth/drive.appdata',
    ],
  );

  Future<void> _handleSignIn() async {
    try {
      await _googleSignIn.signIn();
      print('Signed in successfully.');
    } catch (error) {
      print('Error signing in with Google: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Google Sign-In Demo'),
      ),
      body: Center(
        child: OutlinedButton(
          onPressed: _handleSignIn,
          child: Text('Sign in with Google'),
        ),
      ),
    );
  }
}

