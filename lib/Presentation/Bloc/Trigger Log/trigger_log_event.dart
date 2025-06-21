import 'package:equatable/equatable.dart';

abstract class TriggerLogEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetTriggerLogsEvent extends TriggerLogEvent {
  final String greenhouseId;
  final int startTime;
  final int endTime;

  GetTriggerLogsEvent(this.greenhouseId, this.startTime, this.endTime);

  @override
  List<Object> get props => [greenhouseId, startTime, endTime];
}

class SyncTriggerLogsEvent extends TriggerLogEvent {
  final String greenhouseId;
  final int startTime;
  final int endTime;

  SyncTriggerLogsEvent(this.greenhouseId, this.startTime, this.endTime);

  @override
  List<Object> get props => [greenhouseId, startTime, endTime];
}