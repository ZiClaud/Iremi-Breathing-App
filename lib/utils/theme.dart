import 'package:flutter/material.dart';

const Color myBluLight = Color(0xFF07C2E6);
const Color myBlu = Color(0xFF01B3CA);
const Color myBluDark = Color(0xFF007C9A);

const Color myWhite = Color(0xFFFFFFFF);
const Color myLightBackgroundColor = Color(0xFFFFFFFF);
const Color myDarkBackgroundColor = Color(0xFF000000);
const Color myBlack = Color(0xFF000000);

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
  static bool _isDarkTheme = false;

  ThemeMode get iremiTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  setMode(bool darkmode) {
    _isDarkTheme = darkmode;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      primarySwatch: myBluLightMaterial,
      scaffoldBackgroundColor: myLightBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: myBluLight,
//          foregroundColor: Colors.white,
      ),
      /*
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          backgroundColor: JEMORE_BLUE,
        ),
        primaryColor: JEMORE_BLUE,
        backgroundColor: Colors.white,
        scaffoldBackgroundColor: Colors.white,
        iconTheme: const IconThemeData(
          //TODO: FIX
          color: JEMORE_BLUE,
        ),
        timePickerTheme: const TimePickerThemeData(
          //TODO: FIX
          //backgroundColor: JEMORE_BLUE,
          backgroundColor: Colors.white,
          // hourMinuteColor: JEMORE_BLUE,
          hourMinuteTextColor: JEMORE_BLUE,
        ),
        */
//        unselectedWidgetColor: JEMORE_YELLOW,
//        fontFamily: 'Gotham',
      /*
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          headline2: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          headline3: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          headline4: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          headline5: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          headline6: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          bodyText1: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          bodyText2: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          subtitle1: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          subtitle2: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          caption: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
          button: TextStyle(
              color: Colors.black, fontSize: 20, fontFamily: 'Gotham'),
        )
    */
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      primarySwatch: myBluDarkMaterial,
      backgroundColor: myDarkBackgroundColor,
      scaffoldBackgroundColor: myDarkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: myBluDark,
//          foregroundColor: Colors.white,
      ),
      /*
        textTheme: const TextTheme(
          headline1: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          headline2: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          headline3: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          headline4: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          headline5: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          headline6: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          bodyText1: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          bodyText2: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          subtitle1: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          subtitle2: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          caption: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
          button: TextStyle(
              color: Colors.white, fontSize: 20, fontFamily: 'Gotham'),
        )
    */
    );
  }

  static bool isDarkTheme() {
    return _isDarkTheme;
  }

/*
  static OutlineInputBorder detailsOutlineInputBorder() {
    return const OutlineInputBorder(
        borderSide: BorderSide(width: 2, color: blueJEMORE));
  }
  */
}