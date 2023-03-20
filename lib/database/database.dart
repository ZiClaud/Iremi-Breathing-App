import 'package:iremibreathingapp/basics/user.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MyDatabase {
  static final MyDatabase instance = MyDatabase._init();

  static Database? _database;

  MyDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('user.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';
    final boolType = 'BOOLEAN NOT NULL';
    final integerType = 'INTEGER NOT NULL';

    await db.execute('''
CREATE TABLE $tableUser ( 
  ${UserFields.id} $idType, 
  ${UserFields.name} $textType,
  ${UserFields.surname} $textType,
  ${UserFields.sex} $textType,
  ${UserFields.goal} $textType,
  ${UserFields.badges} $textType,
  )
''');
  }

  Future<MyUser> create(MyUser user) async {
    final db = await instance.database;

    final id = await db.insert(tableUser, user.toJson());
    return user.copy(id: id);
  }

  Future<MyUser> readUser(int id) async {
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
  }

  Future<List<MyUser>> readAllUsers() async {
    final db = await instance.database;

    final orderBy = '${UserFields.id} ASC';

    final result = await db.query(tableUser, orderBy: orderBy);

    return result.map((json) => MyUser.fromJson(json)).toList();
  }

  Future<int> update(MyUser user) async {
    final db = await instance.database;

    return db.update(
      tableUser,
      user.toJson(),
      where: '${UserFields.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> delete(int id) async {
    final db = await instance.database;

    return await db.delete(
      tableUser,
      where: '${UserFields.id} = ?',
      whereArgs: [id],
    );
  }

  Future close() async {
    final db = await instance.database;

    db.close();
  }
}

final String tableUser = 'user';
