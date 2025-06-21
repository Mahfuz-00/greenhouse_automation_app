class ControlItemTable {
  static const String tableName = 'control_items';
  static const String id = 'id';
  static const String greenhouseId = 'greenhouse_id';
  static const String name = 'name';
  static const String count = 'count';
  static const String isActive = 'is_active';
  static const String isAuto = 'is_auto';

  static const String createTable = '''
    CREATE TABLE $tableName (
      $id TEXT PRIMARY KEY,
      $greenhouseId TEXT NOT NULL,
      $name TEXT NOT NULL,
      $count INTEGER NOT NULL,
      $isActive INTEGER NOT NULL DEFAULT 0,
      $isAuto INTEGER NOT NULL DEFAULT 0,
      FOREIGN KEY ($greenhouseId) REFERENCES greenhouses(id)
    )
  ''';
}