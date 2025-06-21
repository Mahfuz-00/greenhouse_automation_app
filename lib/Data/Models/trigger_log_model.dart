

import '../../Domain/Entity/trigger_log.dart';

class TriggerLogModel extends TriggerLog {
  TriggerLogModel({
    required super.id,
    required super.greenhouseId,
    required super.controlItemId,
    required super.timestamp,
    required super.isAuto,
  });

  factory TriggerLogModel.fromJson(Map<String, dynamic> json) {
    return TriggerLogModel(
      id: json['id'],
      greenhouseId: json['greenhouse_id'],
      controlItemId: json['control_item_id'],
      timestamp: json['timestamp'],
      isAuto: json['is_auto'] == 1 || json['is_auto'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'greenhouse_id': greenhouseId,
      'control_item_id': controlItemId,
      'timestamp': timestamp,
      'is_auto': isAuto ? 1 : 0,
    };
  }

  TriggerLog toEntity() {
    return TriggerLog(
      id: id,
      greenhouseId: greenhouseId,
      controlItemId: controlItemId,
      timestamp: timestamp,
      isAuto: isAuto,
    );
  }

  factory TriggerLogModel.fromEntity(TriggerLog triggerLog) {
    return TriggerLogModel(
      id: triggerLog.id,
      greenhouseId: triggerLog.greenhouseId,
      controlItemId: triggerLog.controlItemId,
      timestamp: triggerLog.timestamp,
      isAuto: triggerLog.isAuto,
    );
  }
}