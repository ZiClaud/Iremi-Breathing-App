import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/mainPage.dart';
import 'package:iremibreathingapp/pages/registerPageDB.dart';
import 'package:iremibreathingapp/utils/defaultWidget.dart';
import 'package:iremibreathingapp/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:provider/provider.dart';

import 'database/database.dart';

void main() {
  runApp(const MyApp());
}

class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => IremiTheme(),
      child: Consumer<IremiTheme>(
        builder: (context, theme, _) {
          return MaterialApp(
            title: 'MyApp',
            theme: IremiTheme.lightTheme,
            darkTheme: IremiTheme.darkTheme,
            themeMode: theme.iremiTheme,
            home: FutureBuilder<Widget>(
              future: getHomePage(),
              builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
                if (snapshot.hasData) {
                  return snapshot.data!;
                } else {
                  return defaultLoadingScreen();
                }
              },
            ),
          );
        },
      ),
    );
  }
}


class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final IremiTheme _iremiTheme = IremiTheme();
  late SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
    });
    _iremiTheme.addListener(_onThemeChanged);
  }

  void _onThemeChanged() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: IremiTheme.lightTheme,
      darkTheme: IremiTheme.darkTheme,
      themeMode: _iremiTheme.iremiTheme,
      home: FutureBuilder<Widget>(
        future: getHomePage(),
        builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return defaultLoadingScreen();
          }
        },
      ),
    );
  }
}

Future<StatefulWidget> getHomePage() async {
  try {
    if (await MyDatabase.instance.getFirstUser() != null) {
      return MainPage();
    } else {
      return RegisterPageDB();
    }
  } catch (e) {
    print(e.toString());
    return RegisterPageDB();
  }
}