import 'package:equatable/equatable.dart';

abstract class SensorDataEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetSensorDataEvent extends SensorDataEvent {
  final String greenhouseId;
  final int startTime;
  final int endTime;

  GetSensorDataEvent(this.greenhouseId, this.startTime, this.endTime);

  @override
  List<Object> get props => [greenhouseId, startTime, endTime];
}

class SyncSensorDataEvent extends SensorDataEvent {
  final String greenhouseId;

  SyncSensorDataEvent(this.greenhouseId);

  @override
  List<Object> get props => [greenhouseId];
}