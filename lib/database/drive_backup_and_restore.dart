import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:iremibreathingapp/database/database.dart';
import 'package:iremibreathingapp/database/database_dialogs.dart';
import 'package:iremibreathingapp/utils/my_utils.dart';

import '../basics/badge.dart';

String _getTimeNameDB() {
  return "${DateTime.now().year}${DateTime.now().month}${DateTime.now().day}_${DateTime.now().millisecondsSinceEpoch}";
}

Future<void> backupDatabase(BuildContext context) async {
  try {
    await Achievement.backupAchievement(context);
    // Ask user where to save
    final String? outputFile = await FilePicker.platform.saveFile(
      dialogTitle: 'Save database backup',
      fileName: '${dbName}_${_getTimeNameDB()}.db',
      type: FileType.custom,
      allowedExtensions: ['db'],
    );

    if (outputFile == null) {
      if (context.mounted) {
        defaultDialog(context, "Backup cancelled", "No file selected");
      }
      return;
    }

    await MyDatabase.instance.close();

    final dbPath = await MyDatabase.instance.getDBPath();
    await File(dbPath).copy(outputFile);

    if (context.mounted) {
      defaultDialog(context, "Backup successful", "Saved database to internal storage: $outputFile");
    }
  } catch (e) {
    printError('$e');
    if (context.mounted) {
      defaultDialog(context, "Backup failed", "Error saving database to internal storage: $e");
    }
  } finally {
    try {
      await MyDatabase.instance.open();
    } catch (e) {
      if (context.mounted) {
        defaultDialog(
            context, "Backup failed", "Error re-opening database: $e");
      }
    }
  }
}

Future<void> restoreDatabase(BuildContext context) async {
  try {
    // Get the app's documents directory
    String dbPath = await MyDatabase.instance.getDBPath();
    final Directory dbDir = Directory(dbPath);

    // Allow the user to choose a file
    final file = await FilePicker.platform.pickFiles();

    if (file == null) {
      if (context.mounted) {
        defaultDialog(context, "Restore failed", 'User cancelled the action');
      }
      // User cancelled the file picker
      return;
    }

    // Get the chosen file path
    final filePath = file.files.single.path!;

    if (!filePath.endsWith('.db')) {
      if (context.mounted) {
        defaultDialog(
            context, "Restore failed", 'File chosen is not a database');
      }
      throw Exception("File chosen is not a database");
    }

    // Delete the existing database
    await MyDatabase.instance.deleteDB();

    // Copy the chosen file to the app's documents directory with the same name as the database file
    final newFile = File(dbDir.path);
    await newFile.writeAsBytes(await File(filePath).readAsBytes());

    // Show a message to the user indicating that the database was restored
    if (context.mounted) {
      await defaultDialog(context, 'Database restored',
          'The database was restored from internal storage.');
    }
  } catch (e) {
    if (context.mounted) {
      defaultDialog(context, "Restore failed",
          'Error restoring database from internal storage: \n$e');
    }
  }
}

/*
/// TODO: Only works on android.
const String path = "/storage/emulated/0/Download";
Directory downloadDir = Directory(path);

Future<File?> _saveFileToDocumentsDirectory(File file) async {
  if (!await file.exists()) {
    return null;
  }

  final Directory directory = downloadDir;

  // Construct a file path in the Documents directory.
  final String filePath = '${directory.path}/${file.path.split('/').last}';

  // Check if the file already exists in the directory.
  final File existingFile = File(filePath);
  if (await existingFile.exists()) {
    // If the file already exists, delete it.
    await existingFile.delete();
  }

  // Copy the file to the Documents directory.
  try {
    await file.copy(filePath);
    return File(filePath);
  } catch (e) {
    if (kDebugMode) {
      print('Error saving file to Documents directory: $e');
    }
    return null;
  }
}

Future<File> _getDatabaseFileCopy() async {
  String dbPath = await MyDatabase.instance.getDBPath();
  final Directory directory = downloadDir;
  final String newPath = '${directory.path}/IremiDatabaseBackup.db';
  return File(dbPath).copy(newPath);
}

Future<void> backupDatabaseToInternalStorage(BuildContext context) async {
  await Achievement.backupAchievement(context);

  if ((await _askPermission()) == false) {
    if (context.mounted) {
      defaultDialog(context, "Backup failed", 'Permissions not granted');
    }
    return;
  }

  try {
    await MyDatabase.instance.close();
    String dbPath = await MyDatabase.instance.getDBPath();
    final Directory directory = downloadDir;
    final newPath = '${directory.path}/${_getDBName()}_$dbName';
    await File(dbPath).copy(newPath);
    if (context.mounted) {
      defaultDialog(context, "Backup successful",
          "Saved database to internal storage: $newPath");
    }
  } catch (e) {
    printError('$e');
    if (context.mounted) {
      defaultDialog(context, "Backup failed",
          'Error saving database to internal storage: $e');
    }
  } finally {
    try {
      await MyDatabase.instance.open();
    } catch (e) {
      if (context.mounted) {
        defaultDialog(
            context, "Backup failed", 'Error re-opening database: $e');
      }
    }
  }
}

Future<bool> _askPermission() async {
  if (Platform.isAndroid) {
    final permission = await Permission.storage.request();
    final permission2 = await Permission.manageExternalStorage.request();
    return permission.isGranted && permission2.isGranted;
  } else {
    // Other platforms don't require permission to access internal storage
    return true;
  }
}
*/
