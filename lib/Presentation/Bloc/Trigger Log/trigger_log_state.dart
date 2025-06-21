import 'package:equatable/equatable.dart';

import '../../../Domain/Entity/trigger_log.dart';

abstract class TriggerLogState extends Equatable {
  @override
  List<Object> get props => [];
}

class TriggerLogInitial extends TriggerLogState {}

class TriggerLogLoading extends TriggerLogState {}

class TriggerLogLoaded extends TriggerLogState {
  final List<TriggerLog> triggerLogs;

  TriggerLogLoaded(this.triggerLogs);

  @override
  List<Object> get props => [triggerLogs];
}

class TriggerLogError extends TriggerLogState {
  final String message;

  TriggerLogError(this.message);

  @override
  List<Object> get props => [message];
}