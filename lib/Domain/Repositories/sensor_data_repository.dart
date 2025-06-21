import '../Entity/sensor_data.dart';

abstract class SensorDataRepository {
  Future<List<SensorData>> getSensorData(String greenhouseId, int startTime, int endTime);
  Future<void> syncSensorData(String greenhouseId);
}