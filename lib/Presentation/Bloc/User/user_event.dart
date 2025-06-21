import 'package:equatable/equatable.dart';

import '../../../Domain/Entity/user.dart';


abstract class UserEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddUserEvent extends UserEvent {
  final User user;

  AddUserEvent(this.user);

  @override
  List<Object> get props => [user];
}

class EditUserEvent extends UserEvent {
  final User user;

  EditUserEvent(this.user);

  @override
  List<Object> get props => [user];
}

class DeleteUserEvent extends UserEvent {
  final String id;

  DeleteUserEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetUsersEvent extends UserEvent {}