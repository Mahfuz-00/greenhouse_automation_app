import '../Entity/trigger_log.dart';

abstract class TriggerLogRepository {
  Future<List<TriggerLog>> getTriggerLogs(String greenhouseId, int startTime, int endTime);
  Future<void> syncTriggerLogs(String greenhouseId);
}