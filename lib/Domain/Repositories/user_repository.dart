import '../Entity/user.dart';

abstract class UserRepository {
  Future<void> addUser(User user);
  Future<void> editUser(User user);
  Future<void> deleteUser(String id);
  Future<List<User>> getUsers();
  Future<User?> loginUser(String email, String password);
  Future<void> signupUser(User user, String password);
}