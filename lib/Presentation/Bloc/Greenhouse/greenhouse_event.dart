import 'package:equatable/equatable.dart';

import '../../../Domain/Entity/greenhouse.dart';

abstract class GreenhouseEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddGreenhouseEvent extends GreenhouseEvent {
  final Greenhouse greenhouse;

  AddGreenhouseEvent(this.greenhouse);

  @override
  List<Object?> get props => [greenhouse];
}

class EditGreenhouseEvent extends GreenhouseEvent {
  final Greenhouse greenhouse;

  EditGreenhouseEvent(this.greenhouse);

  @override
  List<Object?> get props => [greenhouse];
}

class DeleteGreenhouseEvent extends GreenhouseEvent {
  final String id;

  DeleteGreenhouseEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetGreenhousesEvent extends GreenhouseEvent {
  final String? userId;

  GetGreenhousesEvent(this.userId);

  @override
  List<Object?> get props => [userId];
}

class SyncGreenhouseDataEvent extends GreenhouseEvent {
  final String greenhouseId;

  SyncGreenhouseDataEvent(this.greenhouseId);

  @override
  List<Object> get props => [greenhouseId];
}

class DeleteOldDataEvent extends GreenhouseEvent {}