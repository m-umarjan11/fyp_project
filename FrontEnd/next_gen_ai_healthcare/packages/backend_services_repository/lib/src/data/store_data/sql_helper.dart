import 'package:backend_services_repository/src/user/models/models.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SqlHelper {
  static final SqlHelper _instance = SqlHelper._internal();
  static Database? _database;
  factory SqlHelper() {
    return _instance;
  }
  SqlHelper._internal();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _initDatabase();
      return _database!;
    }
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'user_symptoms.db');
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    String sql = '''CREATE TABLE user(
      id TEXT PRIMARY KEY,
      name TEXT,
      email TEXT,
      image TEXT,
    )''';
    await db.execute(sql);
  }

  Future<void> insertUser(User user) async {
    final db = await database;
    Map<String, dynamic> map = {
      'id': user.userId,
      'name': user.userName,
      'email': user.email,
      'image': user.picture
    };
    await db.insert('user', map, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<bool> checkUser() async {
    final db = await database;
    try {
      Map<String, dynamic> user = (await db.query('user', limit: 1))[0];
      if (user['name'].isNotEmpty) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<void> clearUserTable() async {
    final db = await database;
    await db.delete('user');
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }
}
