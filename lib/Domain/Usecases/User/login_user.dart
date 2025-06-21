import '../../Entity/user.dart';
import '../../Repositories/user_repository.dart';

class LoginUser {
  final UserRepository repository;

  LoginUser(this.repository);

  Future<User?> call(String email, String password) async {
    return await repository.loginUser(email, password);
  }
}