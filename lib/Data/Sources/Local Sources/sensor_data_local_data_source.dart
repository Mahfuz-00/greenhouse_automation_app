import 'package:sqflite/sqflite.dart';

import '../../../Core/Database/Tables/sensor_data_table.dart';
import '../../../Core/Database/database_helper.dart';
import '../../Models/sensor_data_model.dart';

class SensorDataLocalDataSource {
  final DatabaseHelper dbHelper;

  SensorDataLocalDataSource(this.dbHelper);

  Future<List<SensorDataModel>> getSensorData(String greenhouseId, int startTime, int endTime) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      SensorDataTable.tableName,
      where: '${SensorDataTable.greenhouseId} = ? AND ${SensorDataTable.timestamp} BETWEEN ? AND ?',
      whereArgs: [greenhouseId, startTime, endTime],
    );
    return maps.map((map) => SensorDataModel.fromJson(map)).toList();
  }

  Future<void> syncSensorData(List<SensorDataModel> remoteData) async {
    final db = await dbHelper.database;
    for (var data in remoteData) {
      await db.insert(
        SensorDataTable.tableName,
        data.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}