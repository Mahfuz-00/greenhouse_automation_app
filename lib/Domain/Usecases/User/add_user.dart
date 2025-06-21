import '../../Entity/user.dart';
import '../../Repositories/user_repository.dart';

class AddUser {
  final UserRepository repository;

  AddUser(this.repository);

  Future<void> call(User user) async {
    await repository.addUser(user);
  }
}