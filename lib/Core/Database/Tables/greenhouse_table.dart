class GreenhouseTable {
  static const String tableName = 'greenhouses';
  static const String id = 'id';
  static const String location = 'location';
  static const String latitude = 'latitude';
  static const String longitude = 'longitude';
  static const String size = 'size';
  static const String lastUpdated = 'last_updated';
  static const String userId = 'user_id';

  static const String createTable = '''
    CREATE TABLE $tableName (
      $id TEXT PRIMARY KEY,
      $location TEXT NOT NULL,
      $latitude REAL NOT NULL,
      $longitude REAL NOT NULL,
      $size INTEGER NOT NULL,
      $lastUpdated INTEGER NOT NULL,
      $userId TEXT,
      FOREIGN KEY ($userId) REFERENCES users(id)
    )
  ''';
}