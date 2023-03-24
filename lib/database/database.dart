import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/myUtils.dart';

const String tableUser = 'user';

class MyDatabase {
  static final MyDatabase instance = MyDatabase._init();

  static Database? _database;

  MyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    try {
      _database = await _initDB('IremiDatabase.db');
      return _database!;
    } catch (e) {
      printError('Error getting database: $e');
      rethrow;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    try {
      return await openDatabase(path, version: 1, onCreate: _createAllTables);
    } catch (e) {
      printError('Error opening database: $e');
      rethrow;
    }
  }

  Future _createAllTables(Database db, int version) async {
    _createUserTable(db, version);
  }

  Future _close() async {
    try {
      final db = await instance.database;

      db.close();
    } catch (e) {
      printError('Error closing database: $e');
      rethrow;
    }
  }

  Future deleteDB() async {
    try {
      final db = await instance.database;
      await db.close();
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, 'IremiDatabase.db');
      await deleteDatabase(path);
      _database = null;
    } catch (e) {
      printError('Error deleting database: $e');
      rethrow;
    }
  }

  Future _createUserTable(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'BOOLEAN NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    try {
      await db.execute('''
          CREATE TABLE $tableUser (
          ${UserFields.id} $idType,
          ${UserFields.username} $textType,
          ${UserFields.name} $textType,
          ${UserFields.sex} $textType,
          ${UserFields.goal} $textType
          )''');
    } catch (e) {
      printError('Error creating table $tableUser: $e');
      rethrow;
    }
  }

  Future<MyUser> _createUser(MyUser user) async {
    try {
      final db = await instance.database;
      final id = await db.insert(tableUser, user.toJson());
      return user.copy(id: id);
    } catch (e) {
      printError('Error creating user: $e');
      rethrow;
    }
  }

  Future<MyUser> _readUser(int id) async {
    try {
      final db = await instance.database;

      final maps = await db.query(
        tableUser,
        columns: UserFields.values,
        where: '${UserFields.id} = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return MyUser.fromJson(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    } catch (e) {
      printError('Error reading user: $e');
      rethrow;
    }
  }

  Future<MyUser?> _getFirstUser() async {
    try {
      final allUsers = await _readAllUsers();
      if (allUsers.isNotEmpty) {
        return allUsers.first;
      }
      return null;
    } catch (e) {
      printError('Error reading all users: $e');
      rethrow;
    }
  }

  Future<List<MyUser>> _readAllUsers() async {
    try {
      final db = await instance.database;

      const orderBy = '${UserFields.id} ASC';

      final result = await db.query(tableUser, orderBy: orderBy);

      return result.map((json) => MyUser.fromJson(json)).toList();
    } catch (e) {
      printError('Error reading all users: $e');
      rethrow;
    }
  }

  Future<int> _updateUser(MyUser user) async {
    try {
      final db = await instance.database;

      return await db.update(
        tableUser,
        user.toJson(),
        where: '${UserFields.id} = ?',
        whereArgs: [user.id],
      );
    } catch (e) {
      printError('Error updating user: $e');
      rethrow;
    }
  }

  Future<int> _deleteUser(int id) async {
    try {
      final db = await instance.database;

      return await db.delete(
        tableUser,
        where: '${UserFields.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      printError('Error deleting user: $e');
      rethrow;
    }
  }

  Future<MyUser> createUser(MyUser user) async {
    return _createUser(user);
  }

  Future<MyUser?> getFirstUser() async {
    return _getFirstUser();
  }

  Future<List<MyUser>> readAllUsers() async {
    return _readAllUsers();
  }

  Future updateUser(MyUser user) async {
    _updateUser(user);
  }

  Future deleteUser(MyUser user) async {
    _deleteUser(user.id!);
  }
}

Future<void> backupDatabaseToInternalStorage(context) async {
  try {
    // Get the database path
    final dbPath = await MyDatabase.instance.database.then((db) => db.path);

    // Get the app's documents directory
    final dir = await getApplicationDocumentsDirectory();

    // Create a new file in the documents directory with the same name as the database file
    final file = File('${dir.parent.parent.path}/IremiData/IremiDatabase.db');

    // Copy the database file to the new file
    await file.writeAsBytes(await File(dbPath).readAsBytes());

    // Show a message to the user indicating that the database was saved
    await defaultDialog(context, 'Database saved',
        'The database was saved to internal storage.\n Path: ${file.path}');
  } catch (e) {
    defaultDatabaseErrorDialog(
        context, 'Error saving database to internal storage: $e');
  }
}

Future<void> restoreDatabaseFromInternalStorage(BuildContext context) async {
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

    if (!filePath.endsWith('.db')){
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
}
