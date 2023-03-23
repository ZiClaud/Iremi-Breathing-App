import 'package:flutter/material.dart';

import 'myUtils.dart';


IremiTheme myTheme = IremiTheme();

const Color _myBluLight = Color(0xFF07C2E6);
const Color myBluNeutral = Color(0xFF01B3CA);
const Color _myBluDark = Color(0xFF007C9A);

Color myBluLightDark = IremiTheme.isDarkTheme() ? _myBluDark : _myBluLight;
Color myBluLightDarkOpposite = IremiTheme.isDarkTheme() ? _myBluLight : _myBluDark;

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
  static bool _isDarkTheme = isDefaultThemeDark2();

  ThemeMode get iremiTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  void setMode(bool darkmode) {
    _isDarkTheme = darkmode;
    notifyListeners();
  }

  static bool isDarkTheme() {
    return _isDarkTheme;
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: myBluLightMaterial,
      scaffoldBackgroundColor: _myLightBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _myBluLight,
      ),
      textTheme: defaultLightTextTheme(),
      iconTheme: const IconThemeData(
        color: _myBluLight,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _myBluLight),
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
      ),
      textTheme: defaultDarkTextTheme(),
      iconTheme: const IconThemeData(
        color: _myBluDark,
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
          backgroundColor: _myBluDark),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: defaultDarkButtonStyle(),
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: defaultDarkTextStyle(),
      ),
      dialogTheme: DialogTheme(backgroundColor: _myDarkBackgroundColor),
    );
  }
}


TextTheme defaultLightTextTheme() {
  return TextTheme(
    displayLarge: defaultLightTextStyle(),
    displayMedium: defaultLightTextStyle(),
    displaySmall: defaultLightTextStyle(),
    headlineLarge: defaultLightTextStyle(),
    headlineMedium: defaultLightTextStyle(),
    headlineSmall: defaultLightTextStyle(),
    titleLarge: defaultLightTextStyle(),
    titleMedium: defaultLightTextStyle(),
    titleSmall: defaultLightTextStyle(),
    bodyLarge: defaultLightTextStyle(),
    bodyMedium: defaultLightTextStyle(),
    bodySmall: defaultLightTextStyle(),
    labelLarge: defaultLightTextStyle(),
    labelMedium: defaultLightTextStyle(),
    labelSmall: defaultLightTextStyle(),
  );
}

TextTheme defaultDarkTextTheme() {
  return TextTheme(
    displayLarge: defaultDarkTextStyle(),
    displayMedium: defaultDarkTextStyle(),
    displaySmall: defaultDarkTextStyle(),
    headlineLarge: defaultDarkTextStyle(),
    headlineMedium: defaultDarkTextStyle(),
    headlineSmall: defaultDarkTextStyle(),
    titleLarge: defaultDarkTextStyle(),
    titleMedium: defaultDarkTextStyle(),
    titleSmall: defaultDarkTextStyle(),
    bodyLarge: defaultDarkTextStyle(),
    bodyMedium: defaultDarkTextStyle(),
    bodySmall: defaultDarkTextStyle(),
    labelLarge: defaultDarkTextStyle(),
    labelMedium: defaultDarkTextStyle(),
    labelSmall: defaultDarkTextStyle(),
  );
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
    textStyle: defaultLightMSPTextStyle(),
    foregroundColor: defaultLightMSPTextColor(),
  );
}

ButtonStyle defaultDarkButtonStyle() {
  return ButtonStyle(
    textStyle: defaultDarkMSPTextStyle(),
    foregroundColor: defaultDarkMSPTextColor(),
  );
}

MaterialStateProperty<Color> defaultLightMSPTextColor(){
  return MaterialStatePropertyAll(Colors.black);
}

MaterialStateProperty<Color> defaultDarkMSPTextColor(){
  return MaterialStatePropertyAll(Colors.white);
}