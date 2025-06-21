import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'Tables/control_item_table.dart';
import 'Tables/greenhouse_table.dart';
import 'Tables/sensor_data_table.dart';
import 'Tables/trigger_log_table.dart';
import 'Tables/user_table.dart';


class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('greenhouse.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute(GreenhouseTable.createTable);
        await db.execute(UserTable.createTable);
        await db.execute(SensorDataTable.createTable);
        await db.execute(ControlItemTable.createTable);
        await db.execute(TriggerLogTable.createTable);
      },
    );
  }

  Future<void> syncData(String greenhouseId) async {
    final db = await database;
    final oneYearAgo = DateTime.now().subtract(Duration(days: 365)).millisecondsSinceEpoch;
    await db.delete(
      SensorDataTable.tableName,
      where: '${SensorDataTable.timestamp} < ? AND ${SensorDataTable.greenhouseId} = ?',
      whereArgs: [oneYearAgo, greenhouseId],
    );
    await db.delete(
      TriggerLogTable.tableName,
      where: '${TriggerLogTable.timestamp} < ? AND ${TriggerLogTable.greenhouseId} = ?',
      whereArgs: [oneYearAgo, greenhouseId],
    );
  }

  Future<void> deleteOldData() async {
    final db = await database;
    final sevenDaysAgo = DateTime.now().subtract(Duration(days: 7)).millisecondsSinceEpoch;
    await db.delete(
      SensorDataTable.tableName,
      where: '${SensorDataTable.timestamp} < ?',
      whereArgs: [sevenDaysAgo],
    );
    await db.delete(
      TriggerLogTable.tableName,
      where: '${TriggerLogTable.timestamp} < ?',
      whereArgs: [sevenDaysAgo],
    );
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}