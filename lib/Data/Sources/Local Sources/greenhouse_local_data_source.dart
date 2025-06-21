import 'package:sqflite/sqflite.dart';

import '../../../Core/Database/Tables/greenhouse_table.dart';
import '../../../Core/Database/database_helper.dart';
import '../../Models/greenhouse_model.dart';

class GreenhouseLocalDataSource {
  final DatabaseHelper dbHelper;

  GreenhouseLocalDataSource(this.dbHelper);

  Future<void> addGreenhouse(GreenhouseModel greenhouse) async {
    final db = await dbHelper.database;
    await db.insert(GreenhouseTable.tableName, greenhouse.toJson());
  }

  Future<void> updateGreenhouse(GreenhouseModel greenhouse) async {
    final db = await dbHelper.database;
    await db.update(
      GreenhouseTable.tableName,
      greenhouse.toJson(),
      where: '${GreenhouseTable.id} = ?',
      whereArgs: [greenhouse.id],
    );
  }

  Future<void> deleteGreenhouse(String id) async {
    final db = await dbHelper.database;
    await db.delete(
      GreenhouseTable.tableName,
      where: '${GreenhouseTable.id} = ?',
      whereArgs: [id],
    );
  }

  Future<List<GreenhouseModel>> getGreenhouses(String? userId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      GreenhouseTable.tableName,
      where: userId != null ? '${GreenhouseTable.userId} = ?' : null,
      whereArgs: userId != null ? [userId] : null,
    );
    return maps.map((map) => GreenhouseModel.fromJson(map)).toList();
  }

  Future<List<GreenhouseModel>> getGreenhouseData(String greenhouseId, int startTime) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      GreenhouseTable.tableName,
      where: '${GreenhouseTable.id} = ? AND ${GreenhouseTable.lastUpdated} >= ?',
      whereArgs: [greenhouseId, startTime],
    );
    return maps.map((map) => GreenhouseModel.fromJson(map)).toList();
  }

  Future<void> syncGreenhouseData(List<GreenhouseModel> remoteData) async {
    final db = await dbHelper.database;
    for (var greenhouse in remoteData) {
      await db.insert(
        GreenhouseTable.tableName,
        greenhouse.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
    await dbHelper.syncData(remoteData.first.id);
  }

  Future<void> deleteOldData() async {
    await dbHelper.deleteOldData();
  }
}