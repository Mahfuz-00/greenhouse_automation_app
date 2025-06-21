import 'package:equatable/equatable.dart';

import '../../../Domain/Entity/user.dart';


abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);

  @override
  List<Object> get props => [email, password];
}

class SignupEvent extends AuthEvent {
  final User user;
  final String password;

  SignupEvent(this.user, this.password);

  @override
  List<Object> get props => [user, password];
}

class LogoutEvent extends AuthEvent {}