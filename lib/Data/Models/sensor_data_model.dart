

import '../../Domain/Entity/sensor_data.dart';

class SensorDataModel extends SensorData {
  SensorDataModel({
    required super.id,
    required super.greenhouseId,
    required super.timestamp,
    required super.temperature,
    required super.humidity,
    required super.soilMoisture,
  });

  factory SensorDataModel.fromJson(Map<String, dynamic> json) {
    return SensorDataModel(
      id: json['id'],
      greenhouseId: json['greenhouse_id'],
      timestamp: json['timestamp'],
      temperature: json['temperature'],
      humidity: json['humidity'],
      soilMoisture: json['soil_moisture'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'greenhouse_id': greenhouseId,
      'timestamp': timestamp,
      'temperature': temperature,
      'humidity': humidity,
      'soil_moisture': soilMoisture,
    };
  }

  SensorData toEntity() {
    return SensorData(
      id: id,
      greenhouseId: greenhouseId,
      timestamp: timestamp,
      temperature: temperature,
      humidity: humidity,
      soilMoisture: soilMoisture,
    );
  }

  factory SensorDataModel.fromEntity(SensorData sensorData) {
    return SensorDataModel(
      id: sensorData.id,
      greenhouseId: sensorData.greenhouseId,
      timestamp: sensorData.timestamp,
      temperature: sensorData.temperature,
      humidity: sensorData.humidity,
      soilMoisture: sensorData.soilMoisture,
    );
  }
}