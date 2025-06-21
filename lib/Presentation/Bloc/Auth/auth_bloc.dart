import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Domain/Usecases/User/login_user.dart';
import '../../../Domain/Usecases/User/signup_user.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUser loginUser;
  final SignupUser signupUser;

  AuthBloc(this.loginUser, this.signupUser) : super(AuthInitial()) {
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await loginUser(event.email, event.password);
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthError('Invalid credentials'));
        }
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signupUser(event.user, event.password);
        emit(AuthAuthenticated(event.user));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthInitial());
    });
  }
}