import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/mainPage.dart';
import 'package:iremibreathingapp/pages/registerPageDB.dart';
import 'package:iremibreathingapp/utils/defaultWidget.dart';
import 'package:iremibreathingapp/utils/myUtils.dart';
import 'package:iremibreathingapp/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/database.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    runApp(MyApp(prefs: prefs));
  });
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({Key? key, required this.prefs}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late bool _darkMode;

  @override
  void initState() {
    super.initState();

    _darkMode = widget.prefs.getBool('darkMode') ?? isDefaultThemeDark2();

    myTheme.setMode(_darkMode);

    myTheme.addListener(() {
      setState(() {
        _darkMode = IremiTheme.isDarkTheme();
      });
      widget.prefs.setBool('darkMode', _darkMode);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _home(),
      theme: IremiTheme.lightTheme,
      darkTheme: IremiTheme.darkTheme,
      themeMode: myTheme.iremiTheme,
    );
  }
}

FutureBuilder _home() {
  return FutureBuilder<Widget>(
    future: _getFutureFirstPage(),
    builder: (BuildContext context, AsyncSnapshot<Widget> snapshot) {
      if (snapshot.hasData) {
        return snapshot.data!;
      } else {
        return defaultLoadingScreen();
      }
    },
  );
}

Future<StatefulWidget> _getFutureFirstPage() async {
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
