import 'package:flutter/material.dart';

import '../utils/theme.dart';

/// Buttons
Text defaultButtonText(String message) {
  return Text(
    message,
    maxLines: null,
    style: TextStyle(color: myButtonTextColor()),
  );
}

Icon defaultButtonIcon(IconData iconData) {
  return Icon(
    iconData,
    color: myButtonTextColor(),
  );
}

Widget defaultOutlinedButton(
    BuildContext context, String message, IconData iconData,
    {required void Function() onPressed, void Function()? onLongPress}) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 8.0, right: 8.0, left: 8.0),
    child: OutlinedButton(
      onPressed: () => onPressed(),
      onLongPress: onLongPress,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          defaultButtonIcon(iconData),
          const Padding(padding: EdgeInsets.only(left: 4.0, right: 4.0)),
          defaultButtonText(message),
        ],
      ),
    ),
  );
}
