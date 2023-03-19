import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

import '../pages/exerciseDetailsPage.dart';

AppBar defaultAppBar(String title) {
  return AppBar(
    title: Text(title),
    backgroundColor: myBluLight,
  );
}

TextFormField defaultTextFormField(String lable, String text, IconData icon) {
  return TextFormField(
    enabled: false,
    initialValue: text,
    decoration: InputDecoration(
        label: Text(lable),
        prefixIcon: Icon(
          icon,
          color: myBluLight,
        ),
        labelStyle: TextStyle(fontSize: 15, color: Colors.black)),
  );
}

ButtonStyle defaultButtonStyle() {
  return ButtonStyle();
}
