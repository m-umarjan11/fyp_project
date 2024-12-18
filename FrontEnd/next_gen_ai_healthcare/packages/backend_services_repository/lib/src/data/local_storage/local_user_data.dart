import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:sqflite/sqflite.dart';

class LocalUserData {
  static final LocalUserData _instance = LocalUserData._internal();
  factory LocalUserData(){
    return _instance;
  }
  LocalUserData._internal();
   final SqlHelper _sqlHelper = SqlHelper();
  Future<void> insertUser(User user) async {
    final db = await _sqlHelper.database;
    Map<String, dynamic> map = {
      'id': user.userId,
      'name': user.userName,
      'email': user.email,
      'image': user.picture
    };
    int a = await db.insert('user', map, conflictAlgorithm: ConflictAlgorithm.replace);
    print(a);
  }

  Future<bool> checkUser() async {
    final db = await _sqlHelper.database;
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
  
  Future<Map<String, dynamic>> getUser()async{
    final db = await _sqlHelper.database;
    try {
      Map<String, dynamic> user = (await db.query('user', limit: 1))[0];
      if (user['name'].isNotEmpty) {
        return user;
      } else {
        return {};
      }
    } catch (e) {
      return {};
    }
  }

  Future<void> clearUserTable() async {
    final db = await _sqlHelper.database;
    await db.delete('user');
  }
}