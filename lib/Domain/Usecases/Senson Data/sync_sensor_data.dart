import '../../Repositories/sensor_data_repository.dart';

class SyncSensorData {
  final SensorDataRepository repository;

  SyncSensorData(this.repository);

  Future<void> call(String greenhouseId) async {
    await repository.syncSensorData(greenhouseId);
  }
}