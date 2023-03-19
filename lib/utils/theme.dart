import 'package:flutter/material.dart';

const Color myBluLight = Color(0xFF07C2E6);
const Color myBlu = Color(0xFF01B3CA);
const Color myBluDark = Color(0xFF007C9A);

const Color myWhite = Color(0xFFFFFFFF);
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
