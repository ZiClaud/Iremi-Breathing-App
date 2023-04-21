import 'package:flutter/material.dart';
import 'package:iremibreathingapp/pages/home_page.dart';
import 'package:iremibreathingapp/pages/register_page.dart';
import 'package:iremibreathingapp/utils/default_widgets.dart';
import 'package:iremibreathingapp/utils/my_utils.dart';
import 'package:iremibreathingapp/utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'database/database.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((prefs) async {
    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;

    if (isFirstTime) {
      // Set default settings for the first time
      prefs.setBool('darkMode', isDefaultThemeDark());
      //TODO: Change "true" to "isDefaultThemeDark()"
      prefs.setBool('music', true);
      prefs.setBool('voice', true);
      prefs.setString('voiceType', getDefaultVoiceType2());
      prefs.setString('language', getDefaultLanguage());
      prefs.setBool('dev', false);

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

    _darkMode = widget.prefs.getBool('darkMode') ?? isDefaultThemeDark();

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
        return defaultLogoWidget();
      }
    },
  );
}

Future<StatefulWidget> _getFutureFirstPage() async {
  try {
    if (await DBMyUser().getFirstUser() != null) {
      return HomePage();
    } else {
      return const RegisterPageDB();
    }
  } catch (e) {
    print(e.toString());
//    defaultDatabaseErrorDialog(context, "Error connecting to database");
    return const RegisterPageDB(); // TODO: Maybe change this to MainPage, telling the user that the database is not connected
  }
}
