import 'package:get_it/get_it.dart';

import '../../Data/Repositories/control_item_repository_impl.dart';
import '../../Data/Repositories/greenhouse_repository_impl.dart';
import '../../Data/Repositories/sensor_data_repository_impl.dart';
import '../../Data/Repositories/trigger_log_repository_impl.dart';
import '../../Data/Repositories/user_repository_impl.dart';
import '../../Data/Sources/Local Sources/control_item_local_data_source.dart';
import '../../Data/Sources/Local Sources/greenhouse_local_data_source.dart';
import '../../Data/Sources/Local Sources/sensor_data_local_data_source.dart';
import '../../Data/Sources/Local Sources/trigger_log_local_data_source.dart';
import '../../Data/Sources/Local Sources/user_local_data_source.dart';
import '../../Data/Sources/Remote Sources/control_item_remote_data_source.dart';
import '../../Data/Sources/Remote Sources/greenhouse_remote_data_source.dart';
import '../../Data/Sources/Remote Sources/sensor_data_remote_data_source.dart';
import '../../Data/Sources/Remote Sources/trigger_log_remote_data_source.dart';
import '../../Data/Sources/Remote Sources/user_remote_data_source.dart';
import '../../Domain/Repositories/control_item_repository.dart';
import '../../Domain/Repositories/greenhouse_repository.dart';
import '../../Domain/Repositories/sensor_data_repository.dart';
import '../../Domain/Repositories/trigger_log_repository.dart';
import '../../Domain/Repositories/user_repository.dart';
import '../../Domain/Usecases/Control Items/get_control_items.dart';
import '../../Domain/Usecases/Control Items/update_control_item.dart';
import '../../Domain/Usecases/Greenhouse/add_greenhouse.dart';
import '../../Domain/Usecases/Greenhouse/delete_greenhouse.dart';
import '../../Domain/Usecases/Greenhouse/delete_old_data.dart';
import '../../Domain/Usecases/Greenhouse/edit_greenhouse.dart';
import '../../Domain/Usecases/Greenhouse/get_greenhouses.dart';
import '../../Domain/Usecases/Greenhouse/sync_greenhouse_data.dart';
import '../../Domain/Usecases/Sensor Data/get_sensor_data.dart';
import '../../Domain/Usecases/Sensor Data/sync_sensor_data.dart';
import '../../Domain/Usecases/Trigger Log/get_trigger_logs.dart';
import '../../Domain/Usecases/Trigger Log/sync_trigger_logs.dart';
import '../../Domain/Usecases/User/add_user.dart';
import '../../Domain/Usecases/User/delete_user.dart';
import '../../Domain/Usecases/User/edit_user.dart';
import '../../Domain/Usecases/User/get_users.dart';
import '../../Domain/Usecases/User/login_user.dart';
import '../../Domain/Usecases/User/signup_user.dart';
import '../../Presentation/Bloc/Auth/auth_bloc.dart';
import '../../Presentation/Bloc/Control Items/control_item_bloc.dart';
import '../../Presentation/Bloc/Greenhouse/greenhouse_bloc.dart';
import '../../Presentation/Bloc/Sensor Data/sensor_data_bloc.dart';
import '../../Presentation/Bloc/Trigger Log/trigger_log_bloc.dart';
import '../../Presentation/Bloc/User/user_bloc.dart';
import '../../Core/Database/database_helper.dart';




final getIt = GetIt.instance;

Future<void> setupDependencies() async {
  // Database
  getIt.registerSingleton<DatabaseHelper>(DatabaseHelper.instance);

  // Data Sources
  getIt.registerLazySingleton<GreenhouseLocalDataSource>(() => GreenhouseLocalDataSource(getIt()));
  getIt.registerLazySingleton<UserLocalDataSource>(() => UserLocalDataSource(getIt()));
  getIt.registerLazySingleton<SensorDataLocalDataSource>(() => SensorDataLocalDataSource(getIt()));
  getIt.registerLazySingleton<ControlItemLocalDataSource>(() => ControlItemLocalDataSource(getIt()));
  getIt.registerLazySingleton<TriggerLogLocalDataSource>(() => TriggerLogLocalDataSource(getIt()));
  getIt.registerLazySingleton<GreenhouseRemoteDataSource>(() => GreenhouseRemoteDataSource());
  getIt.registerLazySingleton<UserRemoteDataSource>(() => UserRemoteDataSource());
  getIt.registerLazySingleton<SensorDataRemoteDataSource>(() => SensorDataRemoteDataSource());
  getIt.registerLazySingleton<ControlItemRemoteDataSource>(() => ControlItemRemoteDataSource());
  getIt.registerLazySingleton<TriggerLogRemoteDataSource>(() => TriggerLogRemoteDataSource());

  // Repositories
  getIt.registerLazySingleton<GreenhouseRepository>(() => GreenhouseRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<SensorDataRepository>(() => SensorDataRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<ControlItemRepository>(() => ControlItemRepositoryImpl(getIt(), getIt()));
  getIt.registerLazySingleton<TriggerLogRepository>(() => TriggerLogRepositoryImpl(getIt(), getIt()));

  // Use Cases
  getIt.registerLazySingleton(() => AddGreenhouse(getIt()));
  getIt.registerLazySingleton(() => EditGreenhouse(getIt()));
  getIt.registerLazySingleton(() => DeleteGreenhouse(getIt()));
  getIt.registerLazySingleton(() => GetGreenhouses(getIt()));
  getIt.registerLazySingleton(() => SyncGreenhouseData(getIt()));
  getIt.registerLazySingleton(() => DeleteOldData(getIt()));
  getIt.registerLazySingleton(() => AddUser(getIt()));
  getIt.registerLazySingleton(() => EditUser(getIt()));
  getIt.registerLazySingleton(() => DeleteUser(getIt()));
  getIt.registerLazySingleton(() => GetUsers(getIt()));
  getIt.registerLazySingleton(() => LoginUser(getIt()));
  getIt.registerLazySingleton(() => SignupUser(getIt()));
  getIt.registerLazySingleton(() => GetSensorData(getIt()));
  getIt.registerLazySingleton(() => SyncSensorData(getIt()));
  getIt.registerLazySingleton(() => GetControlItems(getIt()));
  getIt.registerLazySingleton(() => UpdateControlItem(getIt()));
  getIt.registerLazySingleton(() => GetTriggerLogs(getIt()));
  getIt.registerLazySingleton(() => SyncTriggerLogs(getIt()));

  // Blocs
  getIt.registerFactory(() => AuthBloc(getIt(), getIt()));
  getIt.registerFactory(() => GreenhouseBloc(getIt(), getIt(), getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory(() => UserBloc(getIt(), getIt(), getIt(), getIt()));
  getIt.registerFactory(() => SensorDataBloc(getIt(), getIt()));
  getIt.registerFactory(() => ControlItemBloc(getIt(), getIt()));
  getIt.registerFactory(() => TriggerLogBloc(getIt(), getIt()));
}