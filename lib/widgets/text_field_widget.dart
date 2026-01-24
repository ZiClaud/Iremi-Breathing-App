import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Text Form Fields
TextFormField defaultEditTextFormField(String label, IconData icon, controller,
    {required void Function(String?) onChanged}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(label: Text(label), icon: Icon(icon)),
    keyboardType: TextInputType.multiline,
    maxLines: null,
    onChanged: onChanged,
  );
}

TextFormField defaultEditTextFormFieldNum(
    String label, IconData icon, controller,
    {required void Function(String?) onChanged}) {
  return TextFormField(
    controller: controller,
    decoration: InputDecoration(label: Text(label), icon: Icon(icon)),
    keyboardType: TextInputType.number,
    maxLines: null,
    onChanged: onChanged,
    inputFormatters: <TextInputFormatter>[
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
      FilteringTextInputFormatter.digitsOnly
    ],
  );
}

InputDecorator defaultInputDecorator(String label, String text, IconData icon) {
  return InputDecorator(
    decoration: InputDecoration(
      labelText: label,
      icon: Icon(icon),
    ),
    child: Text(text),
  );
}

RoundedRectangleBorder defaultRoundedRectangleBorder() {
  return RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(24.0),
    // side: BorderSide(color: myBluLightDark(), width: 1.5),
  );
}
