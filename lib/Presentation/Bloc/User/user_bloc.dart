import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../Domain/Usecases/User/add_user.dart';
import '../../../Domain/Usecases/User/delete_user.dart';
import '../../../Domain/Usecases/User/edit_user.dart';
import '../../../Domain/Usecases/User/get_users.dart';
import 'user_event.dart';
import 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final AddUser addUser;
  final EditUser editUser;
  final DeleteUser deleteUser;
  final GetUsers getUsers;

  UserBloc(this.addUser, this.editUser, this.deleteUser, this.getUsers) : super(UserInitial()) {
    on<AddUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        await addUser(event.user);
        final users = await getUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<EditUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        await editUser(event.user);
        final users = await getUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<DeleteUserEvent>((event, emit) async {
      emit(UserLoading());
      try {
        await deleteUser(event.id);
        final users = await getUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });

    on<GetUsersEvent>((event, emit) async {
      emit(UserLoading());
      try {
        final users = await getUsers();
        emit(UserLoaded(users));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
  }
}