import 'package:flutter/material.dart';

import 'my_utils.dart';

IremiTheme myTheme = IremiTheme();
const Color _myBluLight = Color(0xFF07C2E6);
const Color myBluNeutral = Color(0xFF01B3CA);
const Color _myBluDark = Color(0xFF007C9A);

const Color myButtonTextColor = Color(0xFFFFFFFF);

const Color _myWhite = Color(0xFFFFFFFF);
const Color _myLightBackgroundColor = Color(0xFFF5F5F5);
const Color _myLightBackgroundColorCard = Color(0xFFFFFFFF);
const Color _myDarkBackgroundColorCard = Color(0xFF444444);
const Color _myDarkBackgroundColor = Color(0xFF282828);
const Color _myBlack = Color(0xFF000000);
const Color myLockedBadgeColor = Colors.grey;

Color myBluLightDark() {
  return IremiTheme.isDarkTheme() ? _myBluDark : _myBluLight;
}

Color myBluLightDarkOpposite() {
  return IremiTheme.isDarkTheme() ? _myBluLight : _myBluDark;
}

Color myWhiteBlack() {
  return IremiTheme.isDarkTheme() ? _myWhite : _myBlack;
}

Color myWhiteBlackOpposite() {
  return IremiTheme.isDarkTheme() ? _myBlack : _myWhite;
}

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

//ColorScheme myLightColorScheme = ColorScheme(brightness: Brightness.light, primary: _myBluLight, onPrimary: _myBlack, secondary: _myBluLight, onSecondary: _myBlack, error: myBluNeutral, onError: _myBlack, background: _myBluLight, onBackground: _myBluLight, surface: _myBluLight, onSurface: _myBluLight);

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
        foregroundColor: myButtonTextColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _myBluLight,
        selectedItemColor: _myLightBackgroundColor,
        unselectedItemColor: _myBluDark,
        elevation: 0,
      ),
      textTheme: defaultLightTextTheme(),
      iconTheme: const IconThemeData(
        color: _myBluLight,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: defaultLightTextStyle(),
        prefixIconColor: _myBluLight,
        iconColor: _myBluLight,
        fillColor: _myLightBackgroundColor,
        border: InputBorder.none,
      ),
      dialogTheme: const DialogTheme(backgroundColor: _myLightBackgroundColor),
      buttonTheme: const ButtonThemeData(),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _myBluLight,
        foregroundColor: myButtonTextColor,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: defaultLightButtonStyle(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: defaultLightButtonStyle(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: defaultLightButtonStyle(),
      ),
      cardTheme: CardTheme(
        color: _myLightBackgroundColorCard,
      ),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: _myDarkBackgroundColor,
      appBarTheme: const AppBarTheme(
        backgroundColor: _myBluDark,
        foregroundColor: myButtonTextColor,
        elevation: 0,
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: _myBluDark,
        selectedItemColor: _myWhite,
        unselectedItemColor: _myDarkBackgroundColor,
        elevation: 0,
      ),
      textTheme: defaultDarkTextTheme(),
      iconTheme: const IconThemeData(
        color: _myBluDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: defaultDarkTextStyle(),
        prefixIconColor: _myBluDark,
        iconColor: _myBluDark,
        fillColor: _myDarkBackgroundColor,
        border: InputBorder.none,
      ),
      dialogTheme: const DialogTheme(backgroundColor: _myDarkBackgroundColor),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: _myBluDark,
        foregroundColor: myButtonTextColor,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: defaultDarkButtonStyle(),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: defaultDarkButtonStyle(),
      ),
      textButtonTheme: TextButtonThemeData(
        style: defaultDarkButtonStyle(),
      ),
      cardTheme: CardTheme(
        color: _myDarkBackgroundColorCard,
      ),
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

TextStyle getChartDefaultTextStyle() {
  return IremiTheme.isDarkTheme()
      ? defaultDarkTextStyle()
      : defaultLightTextStyle();
}

TextStyle defaultLightTextStyle() {
  return const TextStyle(color: _myBlack, fontSize: 20, fontFamily: 'Gotham');
}

TextStyle defaultDarkTextStyle() {
  return const TextStyle(color: _myWhite, fontSize: 20, fontFamily: 'Gotham');
}

TextStyle defaultButtonTextStyle() {
  return const TextStyle(
      color: myButtonTextColor, fontSize: 20, fontFamily: 'Gotham');
}

TextStyle defaultSmallButtonTextStyle() {
  return const TextStyle(
      color: myButtonTextColor, fontSize: 10, fontFamily: 'Gotham');
}

TextStyle defaultSmallerButtonTextStyle() {
  return const TextStyle(
      color: myButtonTextColor, fontSize: 10, fontFamily: 'Gotham');
}

MaterialStateProperty<TextStyle> defaultLightMSPTextStyle() {
  return MaterialStatePropertyAll(defaultLightTextStyle());
}

MaterialStateProperty<TextStyle> defaultDarkMSPTextStyle() {
  return MaterialStatePropertyAll(defaultDarkTextStyle());
}

MaterialStateProperty<TextStyle> defaultButtonMSPTextStyle() {
  return MaterialStatePropertyAll(defaultDarkTextStyle());
}

ButtonStyle defaultLightButtonStyle() {
  return ButtonStyle(
    textStyle: defaultButtonMSPTextStyle(),
    backgroundColor: defaultLightBluMSPColor(),
    foregroundColor: defaultLightMSPTextColor(),
  );
}

ButtonStyle defaultDarkButtonStyle() {
  return ButtonStyle(
    textStyle: defaultButtonMSPTextStyle(),
    backgroundColor: defaultDarkBluMSPColor(),
    foregroundColor: defaultDarkMSPTextColor(),
  );
}

MaterialStateProperty<Color> defaultLightMSPTextColor() {
  return const MaterialStatePropertyAll(Colors.black);
}

MaterialStateProperty<Color> defaultDarkMSPTextColor() {
  return const MaterialStatePropertyAll(Colors.white);
}

MaterialStateProperty<Color> defaultLightBluMSPColor() {
  return const MaterialStatePropertyAll(_myBluLight);
}

MaterialStateProperty<Color> defaultDarkBluMSPColor() {
  return const MaterialStatePropertyAll(_myBluDark);
}
