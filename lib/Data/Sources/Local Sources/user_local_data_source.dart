import 'package:sqflite/sqflite.dart';

import '../../../Core/Database/Tables/user_table.dart';
import '../../../Core/Database/database_helper.dart';
import '../../Models/user_model.dart';

class UserLocalDataSource {
  final DatabaseHelper dbHelper;

  UserLocalDataSource(this.dbHelper);

  Future<void> addUser(UserModel user) async {
    final db = await dbHelper.database;
    await db.insert(UserTable.tableName, user.toJson(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> updateUser(UserModel user) async {
    final db = await dbHelper.database;
    await db.update(
      UserTable.tableName,
      user.toJson(),
      where: '${UserTable.id} = ?',
      whereArgs: [user.id],
    );
  }

  Future<void> deleteUser(String id) async {
    final db = await dbHelper.database;
    await db.delete(
      UserTable.tableName,
      where: '${UserTable.id} = ?',
      whereArgs: [id],
    );
  }

  Future<List<UserModel>> getUsers() async {
    final db = await dbHelper.database;
    final maps = await db.query(UserTable.tableName);
    return maps.map((map) => UserModel.fromJson(map)).toList();
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      UserTable.tableName,
      where: '${UserTable.email} = ?',
      whereArgs: [email],
    );
    if (maps.isNotEmpty) {
      return UserModel.fromJson(maps.first);
    }
    return null;
  }
}