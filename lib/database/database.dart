import 'package:iremibreathingapp/basics/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../basics/settings.dart';
import '../utils/myUtils.dart';

final String tableUser = 'user';
final String tableSettings = 'settings';

class MyDatabase {
  static final MyDatabase instance = MyDatabase._init();

  static Database? _database;

  MyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    try {
      _database = await _initDB('myDatabase.db');
      return _database!;
    } catch (e) {
      printError('Error getting database: $e');
      throw e;
    }
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    try {
      return await openDatabase(path, version: 1, onCreate: _createAllTables);
    } catch (e) {
      printError('Error opening database: $e');
      throw e;
    }
  }

  Future _createAllTables(Database db, int version) async {
    _createUserTable(db, version);
    _createSettingsTable(db, version);
  }

  Future _createUserTable(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    try {
      await db.execute('''
          CREATE TABLE $tableUser (
          ${UserFields.id} $idType,
          ${UserFields.username} $textType,
          ${UserFields.name} $textType,
          ${UserFields.surname} $textType,
          ${UserFields.sex} $textType,
          ${UserFields.goal} $textType
          )''');
    } catch (e) {
      printError('Error creating table $tableSettings: $e');
      throw e;
    }
  }

  Future _createSettingsTable(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    try {
      await db.execute('''
          CREATE TABLE $tableSettings (
          ${SettingsFields.id} $idType,
          ${SettingsFields.language} $textType,
          ${SettingsFields.darkmode} $boolType,
          ${SettingsFields.music} $boolType,
          ${SettingsFields.voice} $boolType,
          ${SettingsFields.voiceType} $textType
          )''');
    } catch (e) {
      printError('Error creating table $tableSettings: $e');
      throw e;
    }
  }

  Future<MyUser> _createUser(MyUser user) async {
    try {
      final db = await instance.database;
      final id = await db.insert(tableUser, user.toJson());
      return user.copy(id: id);
    } catch (e) {
      printError('Error creating user: $e');
      throw e;
    }
  }

  Future<MySettings> _createSettings(MySettings settings) async {
    try {
      final db = await instance.database;
      final id = await db.insert(tableSettings, settings.toJson());
      return settings.copy(id: id);
    } catch (e) {
      printError('Error creating settings: $e');
      throw e;
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
      throw e;
    }
  }

  Future<MySettings> _readSettings(int id) async {
    try {
      final db = await instance.database;

      final maps = await db.query(
        tableSettings,
        columns: SettingsFields.values,
        where: '${SettingsFields.id} = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return MySettings.fromJson(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    } catch (e) {
      printError('Error reading settings: $e');
      throw e;
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
      throw e;
    }
  }

  Future<MySettings?> _getFirstSettings() async {
    try {
      final allSettings = await _readAllSettings();
      if (allSettings.isNotEmpty) {
        return allSettings.first;
      }
      return null;
    } catch (e) {
      printError('Error reading all settings: $e');
      throw e;
    }
  }

  Future<List<MyUser>> _readAllUsers() async {
    try {
      final db = await instance.database;

      final orderBy = '${UserFields.id} ASC';

      final result = await db.query(tableUser, orderBy: orderBy);

      return result.map((json) => MyUser.fromJson(json)).toList();
    } catch (e) {
      printError('Error reading all users: $e');
      throw e;
    }
  }

  Future<List<MySettings>> _readAllSettings() async {
    try {
      final db = await instance.database;

      final orderBy = '${SettingsFields.id} ASC';

      final result = await db.query(tableSettings, orderBy: orderBy);

      return result.map((json) => MySettings.fromJson(json)).toList();
    } catch (e) {
      printError('Error reading all settings: $e');
      throw e;
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
      throw e;
    }
  }

  Future<int> _updateSettings(MySettings settings) async {
    try {
      final db = await instance.database;

      return await db.update(
        tableSettings,
        settings.toJson(),
        where: '${SettingsFields.id} = ?',
        whereArgs: [settings.id],
      );
    } catch (e) {
      printError('Error updating settings: $e');
      throw e;
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
      throw e;
    }
  }

  Future<int> _deleteSettings(int id) async {
    try {
      final db = await instance.database;

      return await db.delete(
        tableSettings,
        where: '${SettingsFields.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      printError('Error deleting settings: $e');
      throw e;
    }
  }

  Future _close() async {
    try {
      final db = await instance.database;

      db.close();
    } catch (e) {
      printError('Error closing database: $e');
      throw e;
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

  Future<MySettings> createSettings(MySettings settings) async {
    return _createSettings(settings);
  }

  Future<MySettings?> getFirstSettings() async {
    return _getFirstSettings();
  }

  Future<List<MySettings>> readAllSettings() async {
    return _readAllSettings();
  }

  Future updateSettings(MySettings settings) async {
    _updateSettings(settings);
  }

  Future deleteSettings(MySettings settings) async {
    _deleteSettings(settings.id!);
  }
}
