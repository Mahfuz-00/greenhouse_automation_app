

import '../../Domain/Entity/control_item.dart';

class ControlItemModel extends ControlItem {
  ControlItemModel({
    required super.id,
    required super.greenhouseId,
    required super.name,
    required super.count,
    required super.isActive,
    required super.isAuto,
  });

  factory ControlItemModel.fromJson(Map<String, dynamic> json) {
    return ControlItemModel(
      id: json['id'],
      greenhouseId: json['greenhouse_id'],
      name: json['name'],
      count: json['count'],
      isActive: json['is_active'] == 1 || json['is_active'] == true,
      isAuto: json['is_auto'] == 1 || json['is_auto'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'greenhouse_id': greenhouseId,
      'name': name,
      'count': count,
      'is_active': isActive ? 1 : 0,
      'is_auto': isAuto ? 1 : 0,
    };
  }

  ControlItem toEntity() {
    return ControlItem(
      id: id,
      greenhouseId: greenhouseId,
      name: name,
      count: count,
      isActive: isActive,
      isAuto: isAuto,
    );
  }

  factory ControlItemModel.fromEntity(ControlItem controlItem) {
    return ControlItemModel(
      id: controlItem.id,
      greenhouseId: controlItem.greenhouseId,
      name: controlItem.name,
      count: controlItem.count,
      isActive: controlItem.isActive,
      isAuto: controlItem.isAuto,
    );
  }
}