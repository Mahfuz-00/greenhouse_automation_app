import 'package:equatable/equatable.dart';

import '../../../Domain/Entity/sensor_data.dart';

abstract class SensorDataState extends Equatable {
  @override
  List<Object> get props => [];
}

class SensorDataInitial extends SensorDataState {}

class SensorDataLoading extends SensorDataState {}

class SensorDataLoaded extends SensorDataState {
  final List<SensorData> sensorData;

  SensorDataLoaded(this.sensorData);

  @override
  List<Object> get props => [sensorData];
}

class SensorDataError extends SensorDataState {
  final String message;

  SensorDataError(this.message);

  @override
  List<Object> get props => [message];
}