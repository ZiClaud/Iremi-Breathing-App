import '../utils/my_utils.dart';

Future<void> backupDatabaseToGoogleDrive(context) async {
  // TODO: IMPLEMENT
  defaultDatabaseErrorDialog(context, 'Needs implementation');
  /*
  try {
    // Get the database path
    final dbPath = await MyDatabase.instance.database.then((db) => db.path);

    // Get the app's documents directory
    final dir = await getApplicationDocumentsDirectory();

    // Create a new file in the documents directory with the same name as the database file
    final file = File('${dir.path}/IremiDatabase.db');

    // Copy the database file to the new file
    await file.writeAsBytes(await File(dbPath).readAsBytes());

    // Show a message to the user indicating that the database was saved
    await defaultDialog(context, 'Database saved',
        'The database was saved to internal storage.\n Path: ${file.path}');
  } catch (e) {
    defaultDatabaseErrorDialog(
        context, 'Error saving database to internal storage: $e');
  }
  */
}

Future<void> restoreDatabaseFromGoogleDrive(context) async {
  // TODO: IMPLEMENT
  defaultDatabaseErrorDialog(context, 'Needs implementation');
  /*
  try {
    // Get the app's documents directory
    final dir = await getApplicationDocumentsDirectory();

    // Allow the user to choose a file
    final file = await FilePicker.platform.pickFiles();

    if (file == null) {
      // User cancelled the file picker
      return;
    }

    // Get the chosen file path
    final filePath = file.files.single.path!;

    if (!filePath.endsWith('.db')) {
      throw Exception("File chosen is not a database");
    }

    // Delete the existing database
    await MyDatabase.instance.deleteDB();

    // Copy the chosen file to the app's documents directory with the same name as the database file
    final newFile = File('${dir.path}/IremiDatabase.db');
    await newFile.writeAsBytes(await File(filePath).readAsBytes());

    // Show a message to the user indicating that the database was restored
    await defaultDialog(context, 'Database restored',
        'The database was restored from internal storage.');
  } catch (e) {
    defaultDatabaseErrorDialog(
        context, 'Error restoring database from internal storage: \n$e');
  }
  */
}
