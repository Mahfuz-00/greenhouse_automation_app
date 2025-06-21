import '../../Entity/user.dart';
import '../../Repositories/user_repository.dart';

class SignupUser {
  final UserRepository repository;

  SignupUser(this.repository);

  Future<void> call(User user, String password) async {
    await repository.signupUser(user, password);
  }
}