import '../../Domain/Entity/trigger_log.dart';
import '../../Domain/Repositories/trigger_log_repository.dart';
import '../Sources/Local Sources/trigger_log_local_data_source.dart';
import '../Sources/Remote Sources/trigger_log_remote_data_source.dart';

class TriggerLogRepositoryImpl implements TriggerLogRepository {
  final TriggerLogLocalDataSource localDataSource;
  final TriggerLogRemoteDataSource remoteDataSource;

  TriggerLogRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<List<TriggerLog>> getTriggerLogs(String greenhouseId, int startTime, int endTime) async {
    final models = await localDataSource.getTriggerLogs(greenhouseId, startTime, endTime);
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> syncTriggerLogs(String greenhouseId) async {
    final oneYearAgo = DateTime.now().subtract(Duration(days: 365)).millisecondsSinceEpoch;
    final remoteData = await remoteDataSource.getTriggerLogs(greenhouseId, oneYearAgo);
    await localDataSource.syncTriggerLogs(remoteData);
  }
}