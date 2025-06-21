import '../../Entity/sensor_data.dart';
import '../../Repositories/sensor_data_repository.dart';

class GetSensorData {
  final SensorDataRepository repository;

  GetSensorData(this.repository);

  Future<List<SensorData>> call(String greenhouseId, int startTime, int endTime) async {
    return await repository.getSensorData(greenhouseId, startTime, endTime);
  }
}