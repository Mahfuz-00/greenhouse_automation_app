import '../../Entity/trigger_log.dart';
import '../../Repositories/trigger_log_repository.dart';

class GetTriggerLogs {
  final TriggerLogRepository repository;

  GetTriggerLogs(this.repository);

  Future<List<TriggerLog>> call(String greenhouseId, int startTime, int endTime) async {
    return await repository.getTriggerLogs(greenhouseId, startTime, endTime);
  }
}