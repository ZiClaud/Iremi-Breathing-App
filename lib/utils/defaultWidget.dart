import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

AppBar defaultAppBar(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: myBluLight,
  );
}

TextFormField defaultShowTextFormField(
    String label, String text, IconData icon) {
  return TextFormField(
    enabled: false,
    initialValue: text,
    decoration: defaultInputDecoration(label, icon),
    keyboardType: TextInputType.multiline,
    maxLines: null,
  );
}

TextFormField defaultEditTextFormField(String label, IconData icon) {
  return TextFormField(
    decoration: defaultInputDecoration(label, icon),
    keyboardType: TextInputType.multiline,
    maxLines: null,
  );
}

InputDecoration defaultInputDecoration(String label, IconData icon) {
  return InputDecoration(
    label: Text(label),
    prefixIcon: Icon(
      icon,
      color: myBluLight,
    ),
    labelStyle: defaultTextStyle(),
  );
}

TextStyle defaultTextStyle() {
  return TextStyle(fontSize: 15, color: myBlack);
}

FloatingActionButton defaultFloatingActionButton(
    {required IconData icon, void Function()? onPressed}) {
  return FloatingActionButton(
    onPressed: onPressed,
    child: Icon(icon),
    foregroundColor: myWhite,
    backgroundColor: myBluLight,
  );
}

/*
- Not used
ButtonStyle defaultButtonStyle() {
  return OutlinedButton.styleFrom(
    backgroundColor: myBluLight,
    foregroundColor: myBlack,
//    textStyle: defaultTextStyle(),
    side: defaultBorderSide(),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(18.0),
    ),
  );
}

ButtonStyle defaultButtonStyle2() {
  return ButtonStyle(
    backgroundColor: MaterialStatePropertyAll<Color>(myBluLight),
  );
}

BorderSide defaultBorderSide() {
  return BorderSide(
    width: 1.5,
    color: myBluDark,
    style: BorderStyle.solid,
  );
}
 */