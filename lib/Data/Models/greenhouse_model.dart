

import '../../Domain/Entity/greenhouse.dart';

class GreenhouseModel extends Greenhouse {
  GreenhouseModel({
    required super.id,
    required super.location,
    required super.latitude,
    required super.longitude,
    required super.size,
    required super.lastUpdated,
    super.userId,
  });

  factory GreenhouseModel.fromJson(Map<String, dynamic> json) {
    return GreenhouseModel(
      id: json['id'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      size: json['size'],
      lastUpdated: json['last_updated'],
      userId: json['user_id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'size': size,
      'last_updated': lastUpdated,
      'user_id': userId,
    };
  }

  Greenhouse toEntity() {
    return Greenhouse(
      id: id,
      location: location,
      latitude: latitude,
      longitude: longitude,
      size: size,
      lastUpdated: lastUpdated,
      userId: userId,
    );
  }

  factory GreenhouseModel.fromEntity(Greenhouse greenhouse) {
    return GreenhouseModel(
      id: greenhouse.id,
      location: greenhouse.location,
      latitude: greenhouse.latitude,
      longitude: greenhouse.longitude,
      size: greenhouse.size,
      lastUpdated: greenhouse.lastUpdated,
      userId: greenhouse.userId,
    );
  }
}