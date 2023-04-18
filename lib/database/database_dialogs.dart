import 'package:achievement_view/achievement_view.dart';
import 'package:flutter/material.dart';

import '../utils/default_widgets.dart';
import '../utils/my_utils.dart';

/// Database errors
Future? defaultDatabaseErrorDialog(context, String message) {
  printWarning("Database error: " + message);
  return _showSnackbar(context, "Database error: " + message);
}

Future? defaultDatabaseErrorDialog3(context, String message) {
  printWarning("Database error: " + message);
  if (isDev) {
    return _defaultDialog(context, "Database error", message);
  } else {
    _notificationStyleDialog(context, "Database error", message);
    return null;
  }
}

Future _defaultDatabaseErrorDialog2(context, message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Database error"),
        content: Text(message.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: defaultButtonText("Close"),
          ),
        ],
      );
    },
  );
}

/// Notification-Style dialog
void _notificationStyleDialog(
    BuildContext context, String title, String message) {
  AchievementView(
    context,
    title: title,
    subTitle: message,
    icon: Icon(Icons.cloud_circle, color: Colors.white),
    color: Colors.black,
    isCircle: true,
  ).show();
}

/// Default dialog
Future _defaultDialog(context, String title, String message) {
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: Text(message.toString()),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: defaultButtonText("Close"),
          ),
        ],
      );
    },
  );
}

/// Default dialog new
Future<void> _showSnackbar(BuildContext context, String message) async {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message),
      duration: const Duration(seconds: 2),
    ),
  );
}
