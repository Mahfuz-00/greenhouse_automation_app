import '../../Domain/Entity/user.dart';
import '../../Domain/Repositories/user_repository.dart';
import '../Models/user_model.dart';
import '../Sources/Local Sources/user_local_data_source.dart';
import '../Sources/Remote Sources/user_remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final UserLocalDataSource localDataSource;
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.localDataSource, this.remoteDataSource);

  @override
  Future<void> addUser(User user) async {
    final model = UserModel.fromEntity(user);
    await localDataSource.addUser(model);
    await remoteDataSource.addUser(model);
  }

  @override
  Future<void> editUser(User user) async {
    final model = UserModel.fromEntity(user);
    await localDataSource.updateUser(model);
    await remoteDataSource.updateUser(model);
  }

  @override
  Future<void> deleteUser(String id) async {
    await localDataSource.deleteUser(id);
    await remoteDataSource.deleteUser(id);
  }

  @override
  Future<List<User>> getUsers() async {
    final models = await localDataSource.getUsers();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<User?> loginUser(String email, String password) async {
    final model = await remoteDataSource.loginUser(email, password);
    if (model != null) {
      await localDataSource.addUser(model);
      return model.toEntity();
    }
    return null;
  }

  @override
  Future<void> signupUser(User user, String password) async {
    final model = UserModel.fromEntity(user);
    await remoteDataSource.signupUser(model, password);
    await localDataSource.addUser(model);
  }
}