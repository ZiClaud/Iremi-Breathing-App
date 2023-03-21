import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

String dbName = "my_database.db";
String tableName = "object_table";

class MyDatabase {
  static final MyDatabase instance = MyDatabase._init();

  static Database? _database;

  MyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(dbName);
    return _database!;
  }

  Future<Database> _initDB(String dbName) async {
    try {
      final dbPath = await getDatabasesPath();
      final path = join(dbPath, dbName);

      final database =
          await openDatabase(path, version: 1, onCreate: _createTable);
      return database;
    } catch (e) {
      throw Exception('Error initializing database: $e');
    }
  }

  Future<void> _createTable(Database db, int version) async {
    try {
      await db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY,
          name TEXT,
          age INTEGER
        )
      ''');
    } catch (e) {
      throw Exception('Error creating table: $e');
    }
  }

  Future<int> insertObjectInTable(MyObject object) async {
    try {
      final db = await instance.database;
      return await db.insert(tableName, object.toMap());
    } catch (e) {
      throw Exception('Error inserting object: $e');
    }
  }

  Future<List<MyObject>> getObjects() async {
    try {
      final db = await instance.database;
      final result = await db.query(tableName);

      return result.map((json) => MyObject.fromMap(json)).toList();
    } catch (e) {
      throw Exception('Error getting objects: $e');
    }
  }

  Future<void> deleteObjectFromTable(int id) async {
    try {
      final db = await instance.database;
      await db.delete(tableName, where: 'id = ?', whereArgs: [id]);
    } catch (e) {
      throw Exception('Error deleting object: $e');
    }
  }

  Future<void> updateObjectTable(MyObject object) async {
    try {
      final db = await instance.database;
      await db.update(tableName, object.toMap(),
          where: 'id = ?', whereArgs: [object.id]);
    } catch (e) {
      throw Exception('Error updating object: $e');
    }
  }
}

class MyObject {
  final int id;
  final String name;
  final int age;

  MyObject({
    required this.id,
    required this.name,
    required this.age,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'age': age,
    };
  }

  factory MyObject.fromMap(Map<String, dynamic> map) {
    return MyObject(
      id: map['id'],
      name: map['name'],
      age: map['age'],
    );
  }
}

class MyUser2 {
  final int id;
  String username;
  String name;
  String? surname;
  String? sex;
  String goal;
  String badges;

  MyUser2({
    required this.id,
    required this.username,
    required this.name,
    required this.surname,
    required this.sex,
    required this.goal,
    required this.badges,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'name': name,
      'surname': surname,
      'sex': sex,
      'goal': goal,
      'badges': badges,
    };
  }

  factory MyUser2.fromMap(Map<String, dynamic> map) {
    return MyUser2(
      id: map['id'],
      username: map['username'],
      name: map['name'],
      surname: map['surname'],
      sex: map['sex'],
      goal: map['goal'],
      badges: map['badges'],
    );
  }
}
