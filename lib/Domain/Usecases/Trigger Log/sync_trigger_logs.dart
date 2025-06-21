import '../../Repositories/trigger_log_repository.dart';

class SyncTriggerLogs {
  final TriggerLogRepository repository;

  SyncTriggerLogs(this.repository);

  Future<void> call(String greenhouseId) async {
    await repository.syncTriggerLogs(greenhouseId);
  }
}