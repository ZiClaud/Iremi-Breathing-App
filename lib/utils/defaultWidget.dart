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
  );
}

TextFormField defaultEditTextFormField(String label, IconData icon) {
  return TextFormField(
    decoration: defaultInputDecoration(label, icon),
  );
}

InputDecoration defaultInputDecoration(String label, IconData icon) {
  return InputDecoration(
      label: Text(label),
      prefixIcon: Icon(
        icon,
        color: myBluLight,
      ),
      labelStyle: defaultTextStyle());
}

ButtonStyle defaultButtonStyle() {
  return ButtonStyle();
}

TextStyle defaultTextStyle() {
  return TextStyle(fontSize: 15, color: Colors.black);
}
