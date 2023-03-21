import 'package:iremibreathingapp/basics/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../utils/myUtils.dart';

final String tableUser = 'user';

class MyDatabase {
  static final MyDatabase instance = MyDatabase._init();

  static Database? _database;

  MyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    try {
      _database = await _initDB('user.db');
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
      return await openDatabase(path, version: 1, onCreate: _createUserTable);
    } catch (e) {
      printError('Error opening database: $e');
      throw e;
    }
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
      printError('Error creating table: $e');
      throw e;
    }
  }

  Future<MyUser> create(MyUser user) async {
    try {
      final db = await instance.database;
      final id = await db.insert(tableUser, user.toJson());
      return user.copy(id: id);
    } catch (e) {
      printError('Error creating user: $e');
      throw e;
    }
  }

  Future<MyUser> readUser(int id) async {
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

  Future<MyUser?> getFirstUser() async {
    try {
      final allUsers = await readAllUsers();
      if (allUsers.isNotEmpty) {
        return allUsers.first;
      }
      return null;
    } catch (e) {
      printError('Error reading all users: $e');
      throw e;
    }
  }

  Future<List<MyUser>> readAllUsers() async {
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

  Future<int> update(MyUser user) async {
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

  Future<int> delete(int id) async {
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

  Future close() async {
    try {
      final db = await instance.database;

      db.close();
    } catch (e) {
      printError('Error closing database: $e');
      throw e;
    }
  }
}
