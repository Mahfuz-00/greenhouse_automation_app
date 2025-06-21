import 'package:equatable/equatable.dart';

class SensorData extends Equatable {
  final String id;
  final String greenhouseId;
  final int timestamp;
  final double temperature;
  final double humidity;
  final double soilMoisture;

  const SensorData({
    required this.id,
    required this.greenhouseId,
    required this.timestamp,
    required this.temperature,
    required this.humidity,
    required this.soilMoisture,
  });

  @override
  List<Object> get props => [id, greenhouseId, timestamp, temperature, humidity, soilMoisture];
}