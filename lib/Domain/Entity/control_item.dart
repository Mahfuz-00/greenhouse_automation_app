import 'package:equatable/equatable.dart';

class ControlItem extends Equatable {
  final String id;
  final String greenhouseId;
  final String name;
  final int count;
  final bool isActive;
  final bool isAuto;

  const ControlItem({
    required this.id,
    required this.greenhouseId,
    required this.name,
    required this.count,
    required this.isActive,
    required this.isAuto,
  });

  ControlItem copyWith({
    String? id,
    String? greenhouseId,
    String? name,
    int? count,
    bool? isActive,
    bool? isAuto,
  }) {
    return ControlItem(
      id: id ?? this.id,
      greenhouseId: greenhouseId ?? this.greenhouseId,
      name: name ?? this.name,
      count: count ?? this.count,
      isActive: isActive ?? this.isActive,
      isAuto: isAuto ?? this.isAuto,
    );
  }

  @override
  List<Object> get props => [id, greenhouseId, name, count, isActive, isAuto];
}