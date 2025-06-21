import '../../Entity/user.dart';
import '../../Repositories/user_repository.dart';

class EditUser {
  final UserRepository repository;

  EditUser(this.repository);

  Future<void> call(User user) async {
    await repository.editUser(user);
  }
}