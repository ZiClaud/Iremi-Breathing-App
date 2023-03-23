import 'package:flutter/material.dart';
import 'package:iremibreathingapp/utils/theme.dart';

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

Text defaultText(String message) {
  return Text(
    message,
    maxLines: null,
  );
}

Text defaultErrorText(String message) {
  return Text(
    message,
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
      color: myBluLightDark,
    ),
    border: InputBorder.none,
  );
}

ListTile defaultListTile({
  required IconData icon,
  required String title,
  required subtitle,
  required trailing,
  leading,
  onTap,
}) {
  return ListTile(
//    shape: defaultRoundedRectangleBorder(),
    title: defaultShowTextFormField(
        title,
        (subtitle is bool)
            ? (subtitle == true ? "On" : "Off")
            : subtitle.toString(),
        icon),
    trailing: trailing,
    leading: leading,
    onTap: onTap,
  );
}

RoundedRectangleBorder defaultRoundedRectangleBorder() {
  return RoundedRectangleBorder(
    borderRadius: defaultBorderRadius(),
    side: defaultBorderSide(),
  );
}

BorderRadius defaultBorderRadius() {
  return BorderRadius.circular(10.0);
}

BorderSide defaultBorderSide() {
  return BorderSide(color: myBluLightDark, width: 1.5);
}

Scaffold defaultLoadingScreen() {
  return const Scaffold(
    body: Center(
      child: Image(
        image: AssetImage('assets/icon/icon.png'),
      ),
    ),
  );
}