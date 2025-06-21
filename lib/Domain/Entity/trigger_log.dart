import 'package:equatable/equatable.dart';

class TriggerLog extends Equatable {
  final String id;
  final String greenhouseId;
  final String controlItemId;
  final int timestamp;
  final bool isAuto;

  const TriggerLog({
    required this.id,
    required this.greenhouseId,
    required this.controlItemId,
    required this.timestamp,
    required this.isAuto,
  });

  @override
  List<Object> get props => [id, greenhouseId, controlItemId, timestamp, isAuto];
}