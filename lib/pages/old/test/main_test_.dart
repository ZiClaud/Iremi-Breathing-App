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
/*
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
*/

/*

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

void main() {
  // Define a function that returns a MaterialApp widget with the createBackground function
  Widget buildApp() {
    return MaterialApp(
      home: Scaffold(
        body: createBackground(
          Colors.purple,
          myBluLightDark(),
          myBluLightDarkOpposite(),
        ),
      ),
    );
  }

  // Run the app with the buildApp function
  runApp(buildApp());
}


Widget createBackground(
    Color backgroundColor,
    Color firstLineColor,
    Color secondLineColor,
    ) {
  return CustomPaint(
    painter: BackgroundPainter(
      backgroundColor: backgroundColor,
      firstLineColor: firstLineColor,
      secondLineColor: secondLineColor,
    ),
    size: Size.infinite,
  );
}

class BackgroundPainter extends CustomPainter {
  final Color backgroundColor;
  final Color firstLineColor;
  final Color secondLineColor;

  BackgroundPainter({
    required this.backgroundColor,
    required this.firstLineColor,
    required this.secondLineColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = min(size.width, size.height) / 2;

    final paint = Paint()..color = backgroundColor;
    canvas.drawCircle(center, radius, paint);

    final rng = Random();
    final linePaint = Paint()..strokeWidth = 5;

    for (var i = 0; i < 10; i++) {
      final angle = rng.nextDouble() * 2 * pi;
      final distance = rng.nextDouble() * radius;
      final startPoint = center + Offset(cos(angle) * distance, sin(angle) * distance);

      final angle2 = angle + rng.nextDouble() * pi / 3 - pi / 6;
      final distance2 = rng.nextDouble() * radius / 4 + radius / 8;
      final endPoint = center + Offset(cos(angle2) * distance2, sin(angle2) * distance2);

      linePaint.color = i.isEven ? firstLineColor : secondLineColor;
      canvas.drawLine(startPoint, endPoint, linePaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
 */
