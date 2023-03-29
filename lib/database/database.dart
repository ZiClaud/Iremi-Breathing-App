import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:iremibreathingapp/basics/badge.dart';
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

  Future<MyUser> createUser(MyUser user) async {
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

  Future<MyUser?> getFirstUser() async {
    try {
      final allUsers = await readAllUsers();
      if (allUsers.isNotEmpty) {
        return allUsers.first;
      }
      return null;
    } catch (e) {
      printError('Error reading all users: $e');
      rethrow;
    }
  }

  Future<List<MyUser>> readAllUsers() async {
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

  Future<List<MyBadge?>> readAllBadges() async {
    try {
      final db = await instance.database;

      throw Exception("Not implemented yet");

//      const orderBy = '${BadgeFields.id} ASC';

//      final result = await db.query(tableBadges, orderBy: orderBy);

//      return result.map((json) => MyBadge.fromJson(json)).toList();
    } catch (e) {
      printError('Error reading all badges: $e');
      rethrow;
    }
  }

  Future<int> updateUser(MyUser user) async {
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

  Future<int> deleteUser(int id) async {
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
}
