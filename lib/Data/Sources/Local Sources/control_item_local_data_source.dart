import 'package:sqflite/sqflite.dart';

import '../../../Core/Database/Tables/control_item_table.dart';
import '../../../Core/Database/database_helper.dart';
import '../../Models/control_item_model.dart';

class ControlItemLocalDataSource {
  final DatabaseHelper dbHelper;

  ControlItemLocalDataSource(this.dbHelper);

  Future<List<ControlItemModel>> getControlItems(String greenhouseId) async {
    final db = await dbHelper.database;
    final maps = await db.query(
      ControlItemTable.tableName,
      where: '${ControlItemTable.greenhouseId} = ?',
      whereArgs: [greenhouseId],
    );
    return maps.map((map) => ControlItemModel.fromJson(map)).toList();
  }

  Future<void> updateControlItem(ControlItemModel controlItem) async {
    final db = await dbHelper.database;
    await db.update(
      ControlItemTable.tableName,
      controlItem.toJson(),
      where: '${ControlItemTable.id} = ?',
      whereArgs: [controlItem.id],
    );
  }

  Future<void> syncControlItems(List<ControlItemModel> remoteData) async {
    final db = await dbHelper.database;
    for (var item in remoteData) {
      await db.insert(
        ControlItemTable.tableName,
        item.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    }
  }
}