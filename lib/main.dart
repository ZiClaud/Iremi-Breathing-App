import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/mainPage.dart';
import 'package:iremibreathingapp/pages/registerPageDB.dart';
import 'package:iremibreathingapp/utils/defaultWidget.dart';
import 'package:iremibreathingapp/utils/myUtils.dart';
import 'package:iremibreathingapp/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/database.dart';
import 'database/getters.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) {
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // Set default settings for the first time
      prefs.setBool('darkMode', true); //TODO: Exchange "true" to "isDefaultThemeDark2()"
      prefs.setBool('music', true);
      prefs.setBool('voice', true);
      prefs.setString('voiceType', Getters.getFirstVoiceType());
      prefs.setString('language', Getters.getFirstLanguage()); // TODO: Change with user's language

      // Set isFirstTime to false to indicate that the app has been opened before
      prefs.setBool('isFirstTime', false);
    }
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
      return const MainPage();
    } else {
      return RegisterPageDB();
    }
  } catch (e) {
    print(e.toString());
//    defaultDatabaseErrorDialog(context, "Error connecting to database");
    return RegisterPageDB(); // TODO: Maybe change this to MainPage, telling the user that the database is not connected
  }
}
