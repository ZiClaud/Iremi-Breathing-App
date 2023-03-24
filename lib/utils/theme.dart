import 'package:flutter/material.dart';

import 'myUtils.dart';

IremiTheme myTheme = IremiTheme();
Color _myBluLight = const Color(0xFF07C2E6);
Color myBluNeutral = const Color(0xFF01B3CA);
Color _myBluDark = const Color(0xFF007C9A);
//Color _myBluDark = Color(0xFFFF0000); - TODO: Used for Debugging
// TODO: FIX BUG -> Doesn't update ICONS, they will be updated only on refresh

Color myBluLightDark = IremiTheme.isDarkTheme() ? _myBluDark : _myBluLight;
Color myBluLightDarkOpposite =
    IremiTheme.isDarkTheme() ? _myBluLight : _myBluDark;


Color myButtonTextColor = const Color(0xFFFFFFFF);

Color _myWhite = const Color(0xFFFFFFFF);
Color _myLightBackgroundColor = const Color(0xFFFFFFFF);
Color _myDarkBackgroundColor = const Color(0xFF282828);
Color _myBlack = const Color(0xFF000000);

Map<int, Color> myColorMapLight = {
  50: const Color.fromRGBO(7, 194, 230, .1),
  100: const Color.fromRGBO(7, 194, 230, .2),
  200: const Color.fromRGBO(7, 194, 230, .3),
  300: const Color.fromRGBO(7, 194, 230, .4),
  400: const Color.fromRGBO(7, 194, 230, .5),
  500: const Color.fromRGBO(7, 194, 230, .6),
  600: const Color.fromRGBO(7, 194, 230, .7),
  700: const Color.fromRGBO(7, 194, 230, .8),
  800: const Color.fromRGBO(7, 194, 230, .9),
  900: const Color.fromRGBO(7, 194, 230, 1),
};
Map<int, Color> myColorMapDark = {
  50: const Color.fromRGBO(0, 124, 154, .1),
  100: const Color.fromRGBO(0, 124, 154, .2),
  200: const Color.fromRGBO(0, 124, 154, .3),
  300: const Color.fromRGBO(0, 124, 154, .4),
  400: const Color.fromRGBO(0, 124, 154, .5),
  500: const Color.fromRGBO(0, 124, 154, .6),
  600: const Color.fromRGBO(0, 124, 154, .7),
  700: const Color.fromRGBO(0, 124, 154, .8),
  800: const Color.fromRGBO(0, 124, 154, .9),
  900: const Color.fromRGBO(0, 124, 154, 1.0),
};
MaterialColor myBluLightMaterial = MaterialColor(0xFF3B44AC, myColorMapLight);
MaterialColor myBluDarkMaterial = MaterialColor(0xFF3B44AC, myColorMapDark);

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
      appBarTheme: AppBarTheme(
        backgroundColor: _myBluLight,
        foregroundColor: myButtonTextColor,
      ),
      textTheme: defaultLightTextTheme(),
      iconTheme: IconThemeData(
        color: _myBluLight,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: defaultLightTextStyle(),
      ),
      dialogTheme: DialogTheme(backgroundColor: _myLightBackgroundColor),
      buttonTheme: const ButtonThemeData(),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
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
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      scaffoldBackgroundColor: _myDarkBackgroundColor,
      appBarTheme: AppBarTheme(
        backgroundColor: _myBluDark,
        foregroundColor: myButtonTextColor,
      ),
      textTheme: defaultDarkTextTheme(),
      iconTheme: IconThemeData(
        color: _myBluDark,
      ),
      inputDecorationTheme: InputDecorationTheme(
        labelStyle: defaultDarkTextStyle(),
      ),
      dialogTheme: DialogTheme(backgroundColor: _myDarkBackgroundColor),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
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
  return TextStyle(color: _myBlack, fontSize: 20, fontFamily: 'Gotham');
}

TextStyle defaultDarkTextStyle() {
  return TextStyle(color: _myWhite, fontSize: 20, fontFamily: 'Gotham');
}

TextStyle defaultButtonTextStyle() {
  return TextStyle(
      color: myButtonTextColor, fontSize: 20, fontFamily: 'Gotham');
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
  return MaterialStatePropertyAll(_myBluLight);
}

MaterialStateProperty<Color> defaultDarkBluMSPColor() {
  return MaterialStatePropertyAll(_myBluDark);
}