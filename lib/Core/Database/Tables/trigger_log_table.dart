class TriggerLogTable {
  static const String tableName = 'trigger_logs';
  static const String id = 'id';
  static const String greenhouseId = 'greenhouse_id';
  static const String controlItemId = 'control_item_id';
  static const String timestamp = 'timestamp';
  static const String isAuto = 'is_auto';

  static const String createTable = '''
    CREATE TABLE $tableName (
      $id TEXT PRIMARY KEY,
      $greenhouseId TEXT NOT NULL,
      $controlItemId TEXT NOT NULL,
      $timestamp INTEGER NOT NULL,
      $isAuto INTEGER NOT NULL,
      FOREIGN KEY ($greenhouseId) REFERENCES greenhouses(id),
      FOREIGN KEY ($controlItemId) REFERENCES control_items(id)
    )
  ''';
}