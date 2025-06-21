import 'package:equatable/equatable.dart';

import '../../../Domain/Entity/control_item.dart';

abstract class ControlItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetControlItemsEvent extends ControlItemEvent {
  final String greenhouseId;

  GetControlItemsEvent(this.greenhouseId);

  @override
  List<Object> get props => [greenhouseId];
}

class UpdateControlItemEvent extends ControlItemEvent {
  final ControlItem controlItem;

  UpdateControlItemEvent(this.controlItem);

  @override
  List<Object> get props => [controlItem];
}