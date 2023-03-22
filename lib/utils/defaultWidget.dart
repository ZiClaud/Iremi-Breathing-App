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

Text defaultText(String message) {
  return Text(
    message,
    maxLines: null,
    style: defaultTextStyle(),
  );
}

Text defaultErrorText(String message) {
  return Text(
    message,
    style: defaultTextStyle(),
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
    border: InputBorder.none,
  );
}

TextStyle defaultTextStyle() {
  return const TextStyle(fontSize: 15, color: myBlack);
}

FloatingActionButton defaultFloatingActionButton(
    {required IconData icon, void Function()? onPressed}) {
  return FloatingActionButton(
    onPressed: onPressed,
    foregroundColor: myWhite,
    backgroundColor: myBluLight,
    child: Icon(icon),
  );
}

OutlinedButton defaultOutlinedButton(
    {required void Function()? onPressed, required Widget? child}) {
  return OutlinedButton(onPressed: onPressed, child: child);
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
  return const BorderSide(color: myBluLight, width: 1.5);
}

LinearProgressIndicator defaultLinearProgressIndicator2() {
  return LinearProgressIndicator(
    backgroundColor: myBluLight,
    color: myBluLight,
  );
}

Scaffold defaultLoadingScreen() {
  return Scaffold(
    backgroundColor: myWhite,
    body: Center(
      child: Image(
        image: AssetImage('assets/icon/icon.png'),
      ),
    ),
  );
  /*
  return Center(
    child: Image.asset("../../../assets/icon/icon.png"),
  );
  */
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
