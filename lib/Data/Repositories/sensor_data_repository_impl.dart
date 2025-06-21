import '../../Domain/Entity/sensor_data.dart';
import '../../Domain/Repositories/sensor_data_repository.dart';
import '../Sources/Local Sources/sensor_data_local_data_source.dart';
import '../Sources/Remote Sources/sensor_data_remote_data_source.dart';

class SensorDataRepositoryImpl implements SensorDataRepository {
  final SensorDataLocalDataSource localDataSource;
  final SensorDataRemoteDataSource remoteDataSource;

  SensorDataRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<List<SensorData>> getSensorData(String greenhouseId, int startTime, int endTime) async {
    final models = await localDataSource.getSensorData(greenhouseId, startTime, endTime);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> syncSensorData(String greenhouseId) async {
    final oneYearAgo = DateTime.now().subtract(Duration(days: 365)).millisecondsSinceEpoch;
    final remoteData = await remoteDataSource.getSensorData(greenhouseId, oneYearAgo);
    await localDataSource.syncSensorData(remoteData);
  }
}