import 'package:sqflite/sqflite.dart';
import '../../../Core/Database/Tables/trigger_log_table.dart';
import '../../../Core/Database/database_helper.dart';
import '../../Models/trigger_log_model.dart';

class TriggerLogLocalDataSource {
  final DatabaseHelper dbHelper;

  TriggerLogLocalDataSource(this.dbHelper);

  Future<List<TriggerLogModel>> getTriggerLogs(String greenhouseId, int startTime, int endTime) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      TriggerLogTable.tableName,
      where: '${TriggerLogTable.greenhouseId} = ? AND ${TriggerLogTable.timestamp} BETWEEN ? AND ?',
      whereArgs: [greenhouseId, startTime, endTime],
    );
    return maps.map((map) => TriggerLogModel.fromJson(map)).toList();
  }

  Future<void> syncTriggerLogs(List<TriggerLogModel> remoteData) async {
    final db = await dbHelper.database;
    for (var log in remoteData) {
      await db.insert(
        TriggerLogTable.tableName,
        log.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}