import 'package:iremibreathingapp/basics/badge.dart';
import 'package:iremibreathingapp/basics/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../basics/customExercise.dart';
import '../basics/exerciseHistory.dart';
import '../utils/myUtils.dart';

const String tableUser = 'user';
const String tableBadges = 'badges';
const String tableExercises = 'exercises';
const String tableExerciseHistory = 'exerciseHistory';

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

  Future _createAllTables(Database db, int version) async {
    _createUserTable(db, version);
    _createBadgesTable(db, version);
    _createExercisesTable(db, version);
    _createExerciseHistoryTable(db, version);
  }

  Future _createUserTable(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';

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

  Future _createBadgesTable(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT NOT NULL';

    try {
      await db.execute('''
          CREATE TABLE $tableBadges (
          ${BadgeFields.id} $idType,
          ${BadgeFields.date} $textType
          )''');
    } catch (e) {
      printError('Error creating table $tableBadges: $e');
      rethrow;
    }
  }

  Future _createExercisesTable(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    try {
      await db.execute('''
          CREATE TABLE $tableExercises (
          ${CustomExerciseFields.id} $idType,
          ${CustomExerciseFields.name} $textType,
          ${CustomExerciseFields.description} $textType,
          ${CustomExerciseFields.notes} $textType,
          ${CustomExerciseFields.steps} $textType,
          ${CustomExerciseFields.times} $integerType,
          ${CustomExerciseFields.inhaleTimeMs} $integerType,
          ${CustomExerciseFields.holdMiddleTimeMs} $integerType,
          ${CustomExerciseFields.exhaleTimeMs} $integerType,
          ${CustomExerciseFields.holdEndTimeMs} $integerType
          )''');
    } catch (e) {
      printError('Error creating table $tableExercises: $e');
      rethrow;
    }
  }

  void _createExerciseHistoryTable(Database db, int version) {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const integerType = 'INTEGER NOT NULL';

    try {
      db.execute('''
          CREATE TABLE $tableExerciseHistory (
          ${ExerciseHistoryFields.id} $idType,
          ${ExerciseHistoryFields.dateTime} $textType,
          ${ExerciseHistoryFields.exerciseDurationSeconds} $textType
          )''');
    } catch (e) {
      printError('Error creating table $tableExerciseHistory: $e');
      rethrow;
    }
  }
}

/// DBMyUser
class DBMyUser {
  Future<MyUser> createUser(MyUser user) async {
    try {
      final db = await MyDatabase.instance.database;
      final id = await db.insert(tableUser, user.toJson());
      return user.copy(id: id);
    } catch (e) {
      printError('Error creating user: $e');
      rethrow;
    }
  }

  Future<MyUser> _readUser(int id) async {
    try {
      final db = await MyDatabase.instance.database;

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
      final db = await MyDatabase.instance.database;

      const orderBy = '${UserFields.id} ASC';

      final result = await db.query(tableUser, orderBy: orderBy);

      return result.map((json) => MyUser.fromJson(json)).toList();
    } catch (e) {
      printError('Error reading all users: $e');
      rethrow;
    }
  }

  Future<int> updateUser(MyUser user) async {
    try {
      final db = await MyDatabase.instance.database;

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
      final db = await MyDatabase.instance.database;

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

/// DBMyBadge
class DBMyBadge {
  Future<MyBadge> createBadge(MyBadge badge) async {
    try {
      final db = await MyDatabase.instance.database;
      final id = await db.insert(tableBadges, badge.toJson());
      return badge.copy(id: id);
    } catch (e) {
      printError('Error creating badge: $e');
      rethrow;
    }
  }

  Future<MyBadge> _readBadge(int id) async {
    try {
      final db = await MyDatabase.instance.database;

      final maps = await db.query(
        tableBadges,
        columns: BadgeFields.values,
        where: '${BadgeFields.id} = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return MyBadge.fromJson(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    } catch (e) {
      printError('Error reading badge: $e');
      rethrow;
    }
  }

  Future<List<MyBadge>> readAllBadges() async {
    try {
      final db = await MyDatabase.instance.database;

      const orderBy = '${BadgeFields.id} ASC';

      final result = await db.query(tableBadges, orderBy: orderBy);

      return result.map((json) => MyBadge.fromJson(json)).toList();
    } catch (e) {
      printError('Error reading all badges: $e');
      rethrow;
    }
  }

  Future<int> updateBadge(MyBadge badge) async {
    try {
      final db = await MyDatabase.instance.database;

      return await db.update(
        tableBadges,
        badge.toJson(),
        where: '${BadgeFields.id} = ?',
        whereArgs: [badge.id],
      );
    } catch (e) {
      printError('Error updating badge: $e');
      rethrow;
    }
  }

  Future<int> deleteBadge(int id) async {
    try {
      final db = await MyDatabase.instance.database;

      return await db.delete(
        tableBadges,
        where: '${BadgeFields.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      printError('Error deleting badge: $e');
      rethrow;
    }
  }
}

/// DBCustomExercise
class DBCustomExercise {
  Future<CustomExercise> createExercise(CustomExercise exercise) async {
    try {
      final db = await MyDatabase.instance.database;
      final id = await db.insert(tableExercises, exercise.toJson());
      return exercise.copy(id: id);
    } catch (e) {
      printError('Error creating exercise: $e');
      rethrow;
    }
  }

  Future<CustomExercise> _readExercise(int id) async {
    try {
      final db = await MyDatabase.instance.database;

      final maps = await db.query(
        tableExercises,
        columns: CustomExerciseFields.values,
        where: '${CustomExerciseFields.id} = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return CustomExercise.fromJson(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    } catch (e) {
      printError('Error reading exercise: $e');
      rethrow;
    }
  }

  Future<List<CustomExercise>> readAllExercises() async {
    try {
      final db = await MyDatabase.instance.database;

      const orderBy = '${CustomExerciseFields.id} ASC';

      final result = await db.query(tableExercises, orderBy: orderBy);

      return result.map((json) => CustomExercise.fromJson(json)).toList();
    } catch (e) {
      printError('Error reading all exercises: $e');
      rethrow;
    }
  }

  Future<int> updateExercise(CustomExercise exercise) async {
    try {
      final db = await MyDatabase.instance.database;

      return await db.update(
        tableExercises,
        exercise.toJson(),
        where: '${CustomExerciseFields.id} = ?',
        whereArgs: [exercise.id],
      );
    } catch (e) {
      printError('Error updating exercise: $e');
      rethrow;
    }
  }

  Future<int> deleteExercise(int id) async {
    try {
      final db = await MyDatabase.instance.database;

      return await db.delete(
        tableExercises,
        where: '${CustomExerciseFields.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      printError('Error deleting eExercise: $e');
      rethrow;
    }
  }
}


/// DBExerciseHistory
class DBExerciseHistory {
  Future<ExerciseHistory> createExerciseHistory(
      ExerciseHistory exerciseHistory) async {
    try {
      final db = await MyDatabase.instance.database;
      final id = await db.insert(tableExerciseHistory, exerciseHistory.toJson());
      return exerciseHistory.copy(id: id);
    } catch (e) {
      printError('Error creating exerciseHistory: $e');
      rethrow;
    }
  }

  Future<ExerciseHistory> _readExerciseHistory(int id) async {
    try {
      final db = await MyDatabase.instance.database;

      final maps = await db.query(
        tableExerciseHistory,
        columns: ExerciseHistoryFields.values,
        where: '${ExerciseHistoryFields.id} = ?',
        whereArgs: [id],
      );

      if (maps.isNotEmpty) {
        return ExerciseHistory.fromJson(maps.first);
      } else {
        throw Exception('ID $id not found');
      }
    } catch (e) {
      printError('Error reading exerciseHistory: $e');
      rethrow;
    }
  }

  Future<List<ExerciseHistory>> readAllExerciseHistory() async {
    try {
      final db = await MyDatabase.instance.database;

      const orderBy = '${ExerciseHistoryFields.id} ASC';

      final result = await db.query(tableExerciseHistory, orderBy: orderBy);

      return result.map((json) => ExerciseHistory.fromJson(json)).toList();
    } catch (e) {
      printError('Error reading all exerciseHistory: $e');
      rethrow;
    }
  }

  Future<int> updateExerciseHistory(ExerciseHistory exerciseHistory) async {
    try {
      final db = await MyDatabase.instance.database;

      return await db.update(
        tableExerciseHistory,
        exerciseHistory.toJson(),
        where: '${ExerciseHistoryFields.id} = ?',
        whereArgs: [exerciseHistory.id],
      );
    } catch (e) {
      printError('Error updating exerciseHistory: $e');
      rethrow;
    }
  }

  Future<int> deleteExerciseHistory(int id) async {
    try {
      final db = await MyDatabase.instance.database;

      return await db.delete(
        tableExerciseHistory,
        where: '${ExerciseHistoryFields.id} = ?',
        whereArgs: [id],
      );
    } catch (e) {
      printError('Error deleting exerciseHistory: $e');
      rethrow;
    }
  }
}
