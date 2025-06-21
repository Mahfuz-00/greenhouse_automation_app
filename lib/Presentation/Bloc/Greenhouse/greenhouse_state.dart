import 'package:equatable/equatable.dart';

import '../../../Domain/Entity/greenhouse.dart';

abstract class GreenhouseState extends Equatable {
  @override
  List<Object> get props => [];
}

class GreenhouseInitial extends GreenhouseState {}

class GreenhouseLoading extends GreenhouseState {}

class GreenhouseLoaded extends GreenhouseState {
  final List<Greenhouse> greenhouses;

  GreenhouseLoaded(this.greenhouses);

  @override
  List<Object> get props => [greenhouses];
}

class GreenhouseError extends GreenhouseState {
  final String message;

  GreenhouseError(this.message);

  @override
  List<Object> get props => [message];
}