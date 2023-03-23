import 'package:flutter/material.dart';

const Color _myBluLight = Color(0xFF07C2E6);
const Color _myBlu = Color(0xFF01B3CA);
const Color _myBluDark = Color(0xFF007C9A);

Color myBluLightDark = _myBluLight ?? _myBluDark;

const Color _myWhite = Color(0xFFFFFFFF);
const Color _myLightBackgroundColor = Color(0xFFFFFFFF);
const Color _myDarkBackgroundColor = Color(0xFF282828);
const Color _myBlack = Color(0xFF000000);

const Map<int, Color> myColorMapLight = {
  50: Color.fromRGBO(7, 194, 230, .1),
  100: Color.fromRGBO(7, 194, 230, .2),
  200: Color.fromRGBO(7, 194, 230, .3),
  300: Color.fromRGBO(7, 194, 230, .4),
  400: Color.fromRGBO(7, 194, 230, .5),
  500: Color.fromRGBO(7, 194, 230, .6),
  600: Color.fromRGBO(7, 194, 230, .7),
  700: Color.fromRGBO(7, 194, 230, .8),
  800: Color.fromRGBO(7, 194, 230, .9),
  900: Color.fromRGBO(7, 194, 230, 1),
};

const Map<int, Color> myColorMapDark = {
  50: Color.fromRGBO(0, 124, 154, .1),
  100: Color.fromRGBO(0, 124, 154, .2),
  200: Color.fromRGBO(0, 124, 154, .3),
  300: Color.fromRGBO(0, 124, 154, .4),
  400: Color.fromRGBO(0, 124, 154, .5),
  500: Color.fromRGBO(0, 124, 154, .6),
  600: Color.fromRGBO(0, 124, 154, .7),
  700: Color.fromRGBO(0, 124, 154, .8),
  800: Color.fromRGBO(0, 124, 154, .9),
  900: Color.fromRGBO(0, 124, 154, 1.0),
};

const MaterialColor myBluLightMaterial =
    MaterialColor(0xFF3B44AC, myColorMapLight);
const MaterialColor myBluDarkMaterial =
    MaterialColor(0xFF3B44AC, myColorMapDark);

/// ---------------------------

class IremiTheme with ChangeNotifier {
  static bool _isDarkTheme = true;

  ThemeMode get iremiTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  setMode(bool darkmode) {
    _isDarkTheme = darkmode;
    IremiTheme().setMode(darkmode);
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: myBluLightMaterial,
      scaffoldBackgroundColor: _myLightBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _myBluLight,
//          foregroundColor: Colors.white,
      ),
      textTheme: defaultLightTextTheme(),
      iconTheme: const IconThemeData(
        color: _myBluLight,
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: _myBluLight),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: defaultLightButtonStyle(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: defaultLightTextStyle(),
      ),
      dialogTheme: DialogTheme(backgroundColor: _myLightBackgroundColor),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: myBluDarkMaterial,
      backgroundColor: _myDarkBackgroundColor,
      scaffoldBackgroundColor: _myDarkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _myBluDark,
//          foregroundColor: Colors.white,
      ),
      textTheme: defaultDarkTextTheme(),
      iconTheme: const IconThemeData(
        color: _myBluDark,
      ),
      floatingActionButtonTheme:
          FloatingActionButtonThemeData(backgroundColor: _myBluDark),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: defaultDarkButtonStyle(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: defaultDarkTextStyle(),
      ),
      dialogTheme: DialogTheme(backgroundColor: _myDarkBackgroundColor),
    );
  }

  static bool isDarkTheme() {
    return _isDarkTheme;
  }
}

TextTheme defaultLightTextTheme() {
  return TextTheme(
    headline1: defaultLightTextStyle(),
    headline2: defaultLightTextStyle(),
    headline3: defaultLightTextStyle(),
    headline4: defaultLightTextStyle(),
    headline5: defaultLightTextStyle(),
    headline6: defaultLightTextStyle(),
    bodyText1: defaultLightTextStyle(),
    bodyText2: defaultLightTextStyle(),
    subtitle1: defaultLightTextStyle(),
    subtitle2: defaultLightTextStyle(),
    caption: defaultLightTextStyle(),
    button: defaultLightTextStyle(),
  );
}

TextTheme defaultDarkTextTheme() {
  return TextTheme(
      headline1: defaultDarkTextStyle(),
      headline2: defaultDarkTextStyle(),
      headline3: defaultDarkTextStyle(),
      headline4: defaultDarkTextStyle(),
      headline5: defaultDarkTextStyle(),
      headline6: defaultDarkTextStyle(),
      bodyText1: defaultDarkTextStyle(),
      bodyText2: defaultDarkTextStyle(),
      subtitle1: defaultDarkTextStyle(),
      subtitle2: defaultDarkTextStyle(),
      caption: defaultDarkTextStyle(),
      button: defaultDarkTextStyle());
}

TextStyle defaultLightTextStyle() {
  return const TextStyle(
      color: Colors.black, fontSize: 20, fontFamily: 'Gotham');
}

TextStyle defaultDarkTextStyle() {
  return const TextStyle(
      color: Colors.white, fontSize: 20, fontFamily: 'Gotham');
}

MaterialStateProperty<TextStyle> defaultLightMSPTextStyle() {
  return MaterialStatePropertyAll(defaultLightTextStyle());
}

MaterialStateProperty<TextStyle> defaultDarkMSPTextStyle() {
  return MaterialStatePropertyAll(defaultDarkTextStyle());
}

ButtonStyle defaultLightButtonStyle() {
  return ButtonStyle(
    textStyle: defaultLightMSPTextStyle(), // TODO: CHANGE
  );
}

ButtonStyle defaultDarkButtonStyle() {
  return ButtonStyle(
    textStyle: defaultDarkMSPTextStyle(), // TODO: CHANGE
  );
}