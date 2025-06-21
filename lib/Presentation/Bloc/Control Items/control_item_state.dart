import 'package:equatable/equatable.dart';

import '../../../Domain/Entity/control_item.dart';

abstract class ControlItemState extends Equatable {
  @override
  List<Object> get props => [];
}

class ControlItemInitial extends ControlItemState {}

class ControlItemLoading extends ControlItemState {}

class ControlItemLoaded extends ControlItemState {
  final List<ControlItem> controlItems;

  ControlItemLoaded(this.controlItems);

  @override
  List<Object> get props => [controlItems];
}

class ControlItemError extends ControlItemState {
  final String message;

  ControlItemError(this.message);

  @override
  List<Object> get props => [message];
}