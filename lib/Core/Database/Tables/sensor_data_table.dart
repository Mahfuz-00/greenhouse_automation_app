class SensorDataTable {
  static const String tableName = 'sensor_data';
  static const String id = 'id';
  static const String greenhouseId = 'greenhouse_id';
  static const String timestamp = 'timestamp';
  static const String temperature = 'temperature';
  static const String humidity = 'humidity';
  static const String soilMoisture = 'soil_moisture';

  static const String createTable = '''
    CREATE TABLE $tableName (
      $id TEXT PRIMARY KEY,
      $greenhouseId TEXT NOT NULL,
      $timestamp INTEGER NOT NULL,
      $temperature REAL NOT NULL,
      $humidity REAL NOT NULL,
      $soilMoisture REAL NOT NULL,
      FOREIGN KEY ($greenhouseId) REFERENCES greenhouses(id)
    )
  ''';
}