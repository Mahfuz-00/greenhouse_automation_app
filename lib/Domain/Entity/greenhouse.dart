import 'package:equatable/equatable.dart';

class Greenhouse extends Equatable {
  final String id;
  final String location;
  final double latitude;
  final double longitude;
  final int size;
  final int lastUpdated;
  final String? userId;

  const Greenhouse({
    required this.id,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.size,
    required this.lastUpdated,
    this.userId,
  });

  @override
  List<Object?> get props => [id, location, latitude, longitude, size, lastUpdated, userId];
}